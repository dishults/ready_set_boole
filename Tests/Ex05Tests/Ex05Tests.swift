import XCTest

import func Functions.negation_normal_form

final class Tests: XCTestCase {

  let expectedResults = [
    // From the subject
    "AB>": "A!B|",
    "AB=": "AB&A!B!&|",
    "AB|!": "A!B!&",
    "AB&!": "A!B!|",
    "AB|C&!": "A!B!&C!|",
    // Extras
    // >
    "AB!!>": "A!B|",
    "AB!>": "A!B!|",
    "A!B!>": "AB!|",
    "A!B>": "AB|",
    // =
    "A!B=": "A!B&AB!&|",
    "AB!=": "AB!&A!B&|",
    // Multi
    "AB>B|C&!": "AB!&B!&C!|",
      /* !(((A -> B) | B) & C)
       !(((!A | B) | B) & C)    A!B|B|C&!
       !((!A | B) | B) | !C     A!B|B|!C!|
       (!(!A | B) & !B) | !C    A!B|!B!&C!|
       ((A & !B) & !B) | !C     AB!&B!&C!|
       */
  ]

  func testRange() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let result = try? negation_normal_form(&formula)
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
      XCTAssertThrowsError(try negation_normal_form(&formula))
    }
  }

}