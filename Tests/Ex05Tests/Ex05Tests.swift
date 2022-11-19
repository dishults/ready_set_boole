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
    "A!B!=": "A!B!&AB&|",
    // >
    "AB^": "AB|A!B!|&",  // AB^ -> AB|AB&!& -> AB|A!B!|&
    "AB!^": "AB!|A!B|&",
    "A!B!^": "A!B!|AB|&",
    // Multi
    "AB>B|C&!": "AB!&B!&C!|",
    /* !(((A -> B) | B) & C)
       !(((!A | B) | B) & C)    A!B|B|C&!
       !((!A | B) | B) | !C     A!B|B|!C!|
       (!(!A | B) & !B) | !C    A!B|!B!&C!|
       ((A & !B) & !B) | !C     AB!&B!&C!|
       */
    "AB|C&!A=": "A!B!&C!|A&AB|C&A!&|",
    "AB|C&A=": "AB|C&A&A!B!&C!|A!&|",
    "AB|C&!A>": "AB|C&A|",
    "AB|C&!A^": "A!B!&C!|A|AB|C&A!|&",
    "AB|AB&!&!": "A!B!&AB&|",
      /* !((A | B) & !(A & B))
       !((A | B) & (!A | !B))   AB|A!B!|&!
       !(A | B) | !(!A | !B)    AB|!A!B!|!|
       (!A & !B) | (A & B)      A!B!&AB&|
       */
  ]

  func testMain() throws {
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
