public func sat(_ formula: inout String) throws -> Bool {
  let truthTable = try TruthTable(&formula)
  while truthTable.currentTest < truthTable.maxTests {
    let result = try truthTable.runTest()
    if result.hasSuffix("1 |") {
      return true
    }
  }
  return false
}
