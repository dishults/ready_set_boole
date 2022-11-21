import Utils

extension Combo {
  public func distribute() {
    // E.g. A | (B & C)  ->  (A | B) & (A | C)
    if type(of: B) == Combo.self {
      let b = B as! Combo
      B = Combo(A: A.copy(), op: op.copy() as! Char, B: b.B)
      A = Combo(A: A, op: op.copy() as! Char, B: b.A)
    } else if type(of: A) == Combo.self {
      let a = A as! Combo
      A = Combo(A: a.A, op: op.copy() as! Char, B: B)
      B = Combo(A: a.B, op: op.copy() as! Char, B: B.copy())
    } else {
      return
    }

    op.toggleOperator()
  }

  public func changeComboStructure() {
    // E.g. (A | B) | C  ->  A | (B | C)
    guard type(of: A) == Combo.self else {
      return
    }
    let a = A as! Combo
    let newA = a.A
    B = Combo(A: a.B, op: a.op, B: B)
    A = newA
  }

  public func convertToCNF() {
    if type(of: A) == Combo.self {
      let a = (A as! Combo)
      a.convertToCNF()
      if a.op.value == op.value && type(of: B) == Char.self {
        changeComboStructure()
        convertToCNF()
      } else if op.value == "|" && a.op.value == "&" {
        distribute()
        convertToCNF()
      }
    }

    if type(of: B) == Combo.self {
      let b = B as! Combo
      b.convertToCNF()
      if op.value == "|" && b.op.value == "&" {
        distribute()
        convertToCNF()
      }
    }
  }

}

public class CNF: CustomStringConvertible {
  var value: FormulaElement

  public init(_ formula: inout String) throws {
    // Test formula for correctness
    let nnf = try NNF(&formula)

    // Init value
    guard type(of: nnf.value) == Combo.self else {
      value = nnf.value as! Char
      return
    }
    value = nnf.value as! Combo

    // Convert value to CNF
    (value as! Combo).convertToCNF()
  }

  public var description: String {
    return "\(value)"
  }
}

public func conjunctive_normal_form(_ formula: inout String) throws -> String {
  let cnf = try CNF(&formula)
  printInfixDescription(cnf.value.infixDescription)
  return String(describing: cnf)
}
