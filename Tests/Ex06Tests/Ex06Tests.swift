import XCTest

import func Functions.conjunctive_normal_form

final class Tests: XCTestCase {

  let expectedResults = [
    // From the subject
//    "ABCD&|&": "ABC|BD|&&",
    "AB&!": "A!B!|",
    "AB|!": "A!B!&",
    "AB|C&": "AB|C&",
//    "AB|C|D|": "ABCD|||",
//    "AB&C&D&": "ABCD&&&",
//    "AB&!C!|": "A!B!C!||",
//    "AB|!C!&": "A!B!C!&&",
  ]

  func testRange() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let result = try? conjunctive_normal_form(&formula)
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
      XCTAssertThrowsError(try conjunctive_normal_form(&formula))
    }
  }

}
