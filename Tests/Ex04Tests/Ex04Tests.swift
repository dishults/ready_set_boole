import XCTest

import func Functions.get_truth_table
import func Functions.print_truth_table

final class Tests: XCTestCase {

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
    "AB&A|": [
      "| A | B | = |",
      "|---|---|---|",
      "| 0 | 0 | 0 |",
      "| 0 | 1 | 0 |",
      "| 1 | 0 | 1 |",
      "| 1 | 1 | 1 |",
    ]
  ]

  func testRange() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let result = try? get_truth_table(&formula)
      XCTAssertEqual(result, expected)
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
