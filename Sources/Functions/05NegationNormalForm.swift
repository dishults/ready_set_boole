import Utils

public protocol FormulaElement {
  func toggle()
  func copy() -> FormulaElement
  var infixDescription: String { get }
}

public class Char: FormulaElement, CustomStringConvertible {
  var value: Character
  var positive: Bool

  public init(_ value: Character, positive: Bool = true) {
    self.value = value
    self.positive = positive
  }

  public func toggle() {
    positive.toggle()
  }

  public func toggleOperator() {
    value = value == "&" ? "|" : "&"
  }

  public func copy() -> FormulaElement {
    Char(value, positive: positive)
  }

  public var description: String {
    "\(value)\(positive ? "" : "!")"
  }

  public var infixDescription: String {
    "\(positive ? "" : "!")\(value)"
  }

}

public class Combo: FormulaElement, CustomStringConvertible {
  var A: FormulaElement
  var op: Char
  var B: FormulaElement

  init(A: FormulaElement, op: Char, B: FormulaElement) {
    self.A = A
    self.op = op
    self.B = B
  }

  // Toggle using De Morgan’s laws
  public func toggle() {
    if "|&".contains(op.value) {
      op.toggleOperator()
      A.toggle()
      B.toggle()
    } else {
      convertToNNF()
      toggle()
    }
  }

  public func convertToNNF() {
    switch op.value {
    case ">":
      A.toggle()
      op.value = "|"

    case "=":
      let A2 = A.copy()
      let B2 = B.copy()
      A2.toggle()
      B2.toggle()
      A = Combo(A: A, op: Char("&"), B: B)
      op.value = "|"
      B = Combo(A: A2, op: Char("&"), B: B2)

    case "^":
      let A2 = A.copy()
      let B2 = B.copy()
      A2.toggle()
      B2.toggle()
      A = Combo(A: A, op: Char("|"), B: B)
      op.value = "&"
      B = Combo(A: A2, op: Char("|"), B: B2)

    default:
      break
    }
  }

  public func copy() -> FormulaElement {
    Combo(A: A.copy(), op: op.copy() as! Char, B: B.copy())
  }

  public var description: String {
    "\(A)\(B)\(op)"
  }

  public var infixDescription: String {
    "(\(A.infixDescription) \(op.infixDescription) \(B.infixDescription))"
  }

}

public class NNF: CustomStringConvertible {
  var value: FormulaElement

  public init(_ formula: inout String) throws {
    // Test formula for correctness
    let truthTable = try TruthTable(&formula)
    _ = try truthTable.runTest()

    // Init value
    var n = 0
    var tmp = [FormulaElement]()
    for c in truthTable.formula {
      if c == "!" {
        tmp[n - 1].toggle()
        n -= 1
      } else if !c.isASCIIUpperLetter {
        let B = tmp.removeLast()
        let A = tmp.removeLast()
        tmp.append(Combo(A: A, op: Char(c), B: B))
        n -= 2
      } else {
        tmp.append(Char(c))
      }
      n += 1
    }

    // Double check the formula
    guard tmp.count == 1 else {
      throw tmp.count == 0 ? FormulaError.notEnoughValues : FormulaError.tooManyValues
    }
    guard type(of: tmp[0]) == Combo.self else {
      value = tmp[0] as! Char
      return
    }
    value = tmp[0] as! Combo

    // Convert value to NNF
    printInfixDescription(value.infixDescription, terminator: "   ->   ")
    (value as! Combo).convertToNNF()
  }

  public var description: String {
    return "\(value)"
  }

}

public func negation_normal_form(_ formula: inout String) throws -> String {
  let nnf = try NNF(&formula)
  printInfixDescription(nnf.value.infixDescription)
  return String(describing: nnf)
}
