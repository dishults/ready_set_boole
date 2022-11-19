import Utils

public class TruthTable {
  let formula: String
  let sortedKeys: [Character]
  public let maxTests: UInt32
  public var currentTest: UInt32
  var indexedVariables: [Character: Int]

  public var header: [String] {
    [
      "\(sortedKeys.cellsLine) = |",  // Variables
      String(repeating: "|---", count: sortedKeys.count) + "|---|",  // Separator line
    ]
  }

  public init(_ formula: inout String) {
    self.formula = formula.uppercased()
    indexedVariables = [:]
    for c in self.formula {
      if c.isASCIIUpperLetter && !indexedVariables.keys.contains(c) {
        indexedVariables[c] = indexedVariables.count
      }
    }
    sortedKeys = Array(indexedVariables.keys).sorted(by: <)
    maxTests = UInt32(2).pow(UInt32(sortedKeys.count))
    currentTest = 0
  }

  public func runTest() throws -> String {
    // MARK: - Generate test values for variables
    let currentTestBinary = currentTest.binary
    guard sortedKeys.count - currentTestBinary.count >= 0 else {
      throw FormulaError.notEnoughValues
    }
    var testValues = currentTestBinary.addPadding(with: "0", maxCount: sortedKeys.count)

    // MARK: - Generate test formula
    var testFormula = ""
    for c in formula {
      if c.isASCIIUpperLetter {
        let testValue = testValues[indexedVariables[c]!]
        testFormula.append(testValue)
      } else {
        testFormula.append(c)
      }
    }

    // MARK: - Test formula
    let result: Character = try eval_formula(&testFormula) ? "1" : "0"
    testValues.append(result)
    currentTest += 1
    return testValues.cellsLine
  }

}

public func print_truth_table(_ formula: inout String) throws {
  let truthTable = TruthTable(&formula)
  print(truthTable.header.joined(separator: "\n"))
  while truthTable.currentTest < truthTable.maxTests {
    print(try truthTable.runTest())
  }
}
