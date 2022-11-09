import Utils

public class Char: CustomStringConvertible, CustomDebugStringConvertible {
  let isOperator: Bool
  var value: Character
  var positive: Bool

  public init(_ value: Character, positive: Bool = true) {
    self.value = value
    self.positive = positive
    self.isOperator = !value.isASCIIUpperLetter
  }

  public func toggle() {
    self.positive.toggle()
  }

  public func toggleNegativeOperator() {
    value = value == "&" ? "|" : "&"
    toggle()
  }

  public func copy() -> Char {
    Char(value, positive: positive)
  }

  public var isNegativeOperator: Bool {
    isOperator && !positive
  }

  public var description: String {
    "\(value)\(positive ? "" : "!")"
  }

  public var debugDescription: String {
    description
  }

}

public class NNF: CustomStringConvertible, CustomDebugStringConvertible {
  var formula: String
  var nnf: [Char]

  public init(_ formula: UnsafePointer<String>) {
    self.formula = formula.pointee.uppercased()
    nnf = []
  }

  public func initNNF() throws {
    try runBasicChecks()
    var n = 0
    for c in self.formula {
      if c == "!" {
        nnf[n - 1].toggle()
        n -= 1
      } else {
        nnf.append(Char(c))
      }
      n += 1
    }
  }

  public var description: String {
    (nnf.map { String(describing: $0) }).joined()
  }

  public var debugDescription: String {
    description
  }

  /// Test formula for correctness
  func runBasicChecks() throws {
    let truthTable = TruthTable(&formula)
    _ = try truthTable.runTest()
  }

  func processPositiveOperators() throws {
    func findStartOfA(_ n: Int) -> Int {
      var i = n
      while i > 0 {
        if !nnf[i].isOperator && !nnf[i - 1].isOperator {
          return i - 1
        }
        i -= 1
      }
      return n
    }

    var n = 0
    while n < nnf.count {
      let c = nnf[n]
      switch c.value {

      case ">":
        let A = nnf[n - 2]
        A.toggle()
        c.value = "|"
        n += 1

      case "=", "^":
        // Get B2
        let B1 = nnf[n - 1]
        let B2 = B1.copy()

        // Get A2
        let A1 = nnf[n - 2]
        var A2 = [A1.copy()]
        if c.value == "=" {
          B2.toggle()
          A2[0].toggle()
        }
        // Find complete A2
        if A2[0].isOperator {
          let tmpA = A2[0]
          A2 = []
          guard n - 3 >= 0 else {
            throw FormulaError.notEnoughValues
          }
          for i in findStartOfA(n - 3)...n - 3 {
            A2.append(nnf[i].copy())
          }
          A2.append(tmpA)
        }

        // Save A2B2
        if c.value == "=" {
          c.value = "&"
          nnf.insert(contentsOf: A2 + [B2, Char("&"), Char("|")], at: n + 1)
        } else if c.value == "^" {
          c.value = "|"
          nnf.insert(contentsOf: A2 + [B2, Char("&", positive: false), Char("&")], at: n + 1)
        }
        n += A2.count + 3 + 1

      default:
        n += 1
      }

    }
  }

  func processNegativeOperators() throws {
    for (n, c) in nnf.enumerated() {
      if c.isNegativeOperator {
        try convert(n)
        try processNegativeOperators()
        break
      }
    }
  }

  func convert(_ n: Int) throws {
    var n = n
    guard n - 2 >= 0 else {
      throw FormulaError.notEnoughValues
    }
    nnf[n].toggleNegativeOperator()
    for _ in 0..<2 {
      n -= 1
      nnf[n].toggle()
    }
  }

}

public func negation_normal_form(_ formula: UnsafePointer<String>) throws -> String {
  let nnf = NNF(formula)
  try nnf.initNNF()
  try nnf.processPositiveOperators()
  try nnf.processNegativeOperators()
  return String(describing: nnf)
}
