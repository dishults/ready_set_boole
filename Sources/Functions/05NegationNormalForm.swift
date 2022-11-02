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
  
  public func toggleComplexOperator() {
    value = value == "&" ? "|" : "&"
    toggle()
  }

  public func copy() -> Char {
    Char(value, positive: positive)
  }

  public var isComplexOperator: Bool {
    isOperator && !positive
  }

  public var description: String {
    isOperator ? String(value) : "\(value)\(positive ? "" : "!")"
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

  func runBasicConversion() throws {
    var n = 0
    while n < nnf.count {
      let c = nnf[n]
      if c.value == ">" {
        let A = nnf[n - 2]
        A.toggle()
        c.value = "|"

      } else if c.value == "=" {
        let B1 = nnf[n - 1]
        let B2 = B1.copy()
        B2.toggle()
        let A1 = nnf[n - 2]
        let A2 = A1.copy()
        A2.toggle()
        c.value = "&"
        nnf.insert(contentsOf: [A2, B2, Char("&"), Char("|")], at: n + 1)
        n += 4
      }

      n += 1
    }
  }

  func runDeMorganConversion() throws {
    var n = 0
    for c in nnf {
      if c.isComplexOperator {
        try convert(n)
        try runDeMorganConversion()
        break
      }
      n += 1
    }
  }

  func convert(_ n: Int) throws {
    var n = n
    while n > 0 {
      if nnf[n].isComplexOperator {
        nnf[n].toggleComplexOperator()
        n -= 1
        nnf[n].toggle()
        n -= 1
        nnf[n].toggle()
        break
      }
      n -= 1
    }
  }

}

public func negation_normal_form(_ formula: UnsafePointer<String>) throws -> String {
  let nnf = NNF(formula)
  try nnf.initNNF()
  try nnf.runBasicConversion()
  try nnf.runDeMorganConversion()
  return String(describing: nnf)
}
