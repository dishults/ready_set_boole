import XCTest

import func Functions.eval_formula

final class BoolEvalTests: XCTestCase {

  let expectedResults = [
    // From the subject
    "10&": false,
    "10|": true,
    "10=": false,
    "1011||=": true,
    "10|1&": true,
    // Extras
    "0": false,
    "1": true,
    // !
    "0!": true,
    "1!": false,
    "10!=": true,
    // ^
    "00^": false,
    "11^": false,
    "01^": true,
    "10^": true,
    // >
    "11>": true,
    "10>": false,
    "01>": true,
    "00>": true,
  ]

  func testMain() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let result = try? eval_formula(&formula)
      XCTAssertEqual(result, expected)
    }
  }

  let incorrectFormulas = [
    "",
    "1&",
    "0|",
    "0^",
    "1>",
    "1=",
    "111=",
    "!",
    "&",
    "*",
    "10?",
  ]

  func testErrors() throws {
    for var formula in self.incorrectFormulas {
      XCTAssertThrowsError(try eval_formula(&formula))
    }
  }

}
