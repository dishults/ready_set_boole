import XCTest

import func Functions.eval_set

final class Tests: XCTestCase {

  let expectedResults: [String: ([[Int32]], [Int32])] = [
    // From the subject
    "AB&": ([[0, 1, 2], [0, 3, 4]], [0]),
    "AB|": ([[0, 1, 2], [3, 4, 5]], [0, 1, 2, 3, 4, 5]),
    "A!": ([[0, 1, 2]], []),
    // Extras
    "A": ([[0, 1, 2]], [0, 1, 2]),
    "B": ([[]], []),
    "C!": ([[]], []),
    "AB^": ([[0, 1, 2], [0, 3, 4]], [1, 2, 3, 4]),
    "AB=": ([[0, 1, 2], [0, 2, 1]], [0, 1, 2]),
    "AC=": ([[0, 1, 2], [0, 3, 1]], []),
    "BC=": ([[0, 1, 2], [0, 2, 1, 3]], []),
    "A!!": ([[0, 1, 2]], [0, 1, 2]),
    "AB>": ([[0, 1, 2], [0, 3, 4]], [0, 3, 4]),
    "A!B>": ([[0, 1, 2], [0, 3, 4]], [0, 1, 2, 3, 4]),
  ]

  func testMain() throws {
    for (formula, testCase) in self.expectedResults {
      var formula = formula
      var (sets, expected) = testCase
      let results = try eval_set(&formula, &sets)
      XCTAssertEqual(results, expected)
    }
  }

  let incorrectTestCases: [String: [[Int32]]] = [
    "": [[0, 1, 2]],
    "AB|": [[]],
    "A&": [[0, 1, 2]],
    "B|": [[0, 1, 2]],
    "0^": [[0, 1, 2]],
    "1>": [[0, 1, 2]],
    "C=": [[0, 1, 2]],
    "ABC=": [[0, 1, 2]],
    "!": [[0, 1, 2]],
    "&": [[0, 1, 2]],
    "*": [[0, 1, 2]],
    "AB?": [[0, 1, 2]],
    "éA=": [[0, 1, 2]],
  ]

  func testErrors() throws {
    for var (formula, sets) in self.incorrectTestCases {
      XCTAssertThrowsError(try eval_set(&formula, &sets))
    }
  }

}
