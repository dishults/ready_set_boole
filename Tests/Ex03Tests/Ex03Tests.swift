import XCTest

import func Functions.eval_formula

final class Tests: XCTestCase {

  let expectedResults: [String: Bool] = [
    // From the subject
    "10&": false,
    "10|": true,
    "10=": false,
    "1011||=": true,
    "10|1&": true,
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

  func testRange() throws {
    for (formula, expected) in self.expectedResults {
      var formula = formula
      let result = eval_formula(&formula)
      XCTAssertEqual(result, expected)
    }
  }

}
