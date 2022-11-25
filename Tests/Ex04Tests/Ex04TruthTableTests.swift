import XCTest

import class Functions.TruthTable
import func Functions.print_truth_table

final class TruthTableTests: XCTestCase {

  let expectedResults = [
    // From the subject
    "AB&C|": [
      "| A | B | C | = |",
      "|---|---|---|---|",
      "| 0 | 0 | 0 | 0 |",
      "| 0 | 0 | 1 | 1 |",
      "| 0 | 1 | 0 | 0 |",
      "| 0 | 1 | 1 | 1 |",
      "| 1 | 0 | 0 | 0 |",
      "| 1 | 0 | 1 | 1 |",
      "| 1 | 1 | 0 | 1 |",
      "| 1 | 1 | 1 | 1 |",
    ],
    // Extras
    "A": [
      "| A | = |",
      "|---|---|",
      "| 0 | 0 |",
      "| 1 | 1 |",
    ],
    "AB&A|": [
      "| A | B | = |",
      "|---|---|---|",
      "| 0 | 0 | 0 |",
      "| 0 | 1 | 0 |",
      "| 1 | 0 | 1 |",
      "| 1 | 1 | 1 |",
    ],
  ]

  func testMain() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let truthTable = try TruthTable(&formula)
      var results = truthTable.header

      while truthTable.currentTest < truthTable.maxTests {
        let result = try truthTable.runTest()
        results.append(result)
      }
      XCTAssertEqual(results, expected)
    }
  }

  let incorrectFormulas = [
    "",
    "A&",
    "B|",
    "0^",
    "1>",
    "C=",
    "ABC=",
    "!",
    "&",
    "*",
    "AB?",
    "éA=",
  ]

  func testErrors() throws {
    for var formula in self.incorrectFormulas {
      XCTAssertThrowsError(try print_truth_table(&formula))
    }
  }

}
