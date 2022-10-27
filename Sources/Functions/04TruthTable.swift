extension Character {
  public var isASCIIUpperLetter: Bool {
    let asciiValue = self.asciiValue ?? 0
    return asciiValue > 64 && asciiValue < 91
  }
}

extension UInt32 {
  public func pow(_ right: UInt32) -> UInt32 {
    var res: UInt32 = self
    for _ in 1..<right {
      res *= self
    }
    return res
  }
}

public func get_truth_table(_ formula: UnsafePointer<String>) throws -> [String] {
  let formula = formula.pointee.uppercased()
  let sortedKeys: [Character]
  var indexedVariables = [Character: Int]()
  var line = [String]()
  var truthTable = [String]()

  // MARK: - Init variables
  for c in formula {
    if c.isASCIIUpperLetter && !indexedVariables.keys.contains(c) {
      indexedVariables[c] = indexedVariables.count
    }
  }
  sortedKeys = Array(indexedVariables.keys).sorted(by: <)
  for k in sortedKeys {
    line.append("| \(k) ")
  }
  line.append("| = |")
  truthTable.append(line.joined())

  // MARK: - Add separator line
  line = []
  for _ in 0..<sortedKeys.count {
    line.append("|---")
  }
  line.append("|---|")
  truthTable.append(line.joined())

  // MARK: - Run tests
  for i: UInt32 in 0..<UInt32(2).pow(UInt32(sortedKeys.count)) {
    // MARK: - Generate test values for variables
    let iBinary = String(i, radix: 2)
    let zerosPadding = sortedKeys.count - iBinary.count
    let testValues = Array("\(String(repeating: "0", count: zerosPadding))\(iBinary)")

    // MARK: - Generate test formula
    var formulaVersion = [Character]()
    for c in formula {
      if c.isASCIIUpperLetter {
        let testValue = testValues[indexedVariables[c]!]
        formulaVersion.append(testValue)
      } else {
        formulaVersion.append(c)
      }
    }

    // MARK: - Test formula
    var testFormula = String(formulaVersion)
    let result = try eval_formula(&testFormula) ? "1" : "0"

    // MARK: - Save result
    line = []
    for v in testValues {
      line.append("| \(v) ")
    }
    line.append("| \(result) |")
    truthTable.append(line.joined())
  }

  return truthTable
}

public func print_truth_table(_ formula: UnsafePointer<String>) throws {
  let result = try get_truth_table(formula)
  print(result.joined(separator: "\n"))
}
