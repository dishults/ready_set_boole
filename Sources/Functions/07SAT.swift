public func sat(_ formula: UnsafePointer<String>) throws -> Bool {
  let truthTable = TruthTable(formula)
  while truthTable.currentTest < truthTable.maxTests {
    let result = try truthTable.runTest()
    if result.hasSuffix("1 |") {
      return true
    }
  }
  return false
}
