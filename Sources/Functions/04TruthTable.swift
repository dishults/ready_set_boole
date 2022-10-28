import Utils

public func getTruthTable(_ formula: UnsafePointer<String>) throws -> [String] {
  let formula = formula.pointee.uppercased()
  let sortedKeys: [Character]
  var indexedVariables = [Character: Int]()
  var line = ""
  var truthTable = [String]()

  // MARK: - Init variables
  for c in formula {
    if c.isASCIIUpperLetter && !indexedVariables.keys.contains(c) {
      indexedVariables[c] = indexedVariables.count
    }
  }
  sortedKeys = Array(indexedVariables.keys).sorted(by: <)
  line = sortedKeys.cellsLine
  line.append(" = |")
  truthTable.append(line)

  // MARK: - Add separator line
  line = ""
  for _ in 0..<sortedKeys.count {
    line.append("|---")
  }
  line.append("|---|")
  truthTable.append(line)

  // MARK: - Run tests
  for i: UInt32 in 0..<UInt32(2).pow(UInt32(sortedKeys.count)) {
    // MARK: - Generate test values for variables
    let iBinary = i.binary
    let zerosPadding = sortedKeys.count - iBinary.count
    guard zerosPadding >= 0 else {
      throw FormulaError.notEnoughValues
    }
    var testValues = Array("\(String(repeating: "0", count: zerosPadding))\(iBinary)")

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

    // MARK: - Save result
    line = testValues.cellsLine
    truthTable.append(line)
  }

  return truthTable
}

public func print_truth_table(_ formula: UnsafePointer<String>) throws {
  let truthTable = try getTruthTable(formula)
  print(truthTable.joined(separator: "\n"))
}
