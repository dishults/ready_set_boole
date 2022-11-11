import XCTest

import func Functions.sat

final class Tests: XCTestCase {

  let expectedResults = [
    // From the subject
    "AB|": true,
    "AB&": true,
    "AA!&": false,
    "AA^": false,
  ]

  func testRange() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let result = try? sat(&formula)
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
      XCTAssertThrowsError(try sat(&formula))
    }
  }

}
