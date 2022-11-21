import XCTest

import func Functions.powerset

final class Tests: XCTestCase {

  let expectedResults: [[Int32]: [[Int32]]] = [
    []: [[]],
    [1]: [
      [],
      [1],
    ],
    [1, 2, 3]: [
      [],
      [3],
      [2],
      [2, 3],
      [1],
      [1, 3],
      [1, 2],
      [1, 2, 3],
    ],
  ]

  func testMain() throws {
    for (testSet, expected) in self.expectedResults {
      var testSet = testSet
      let result = try powerset(&testSet)
      XCTAssertEqual(result, expected)
    }
  }

  let incorrectSets: [[Int32]] = [
    [1, 1],
    [1, 2, 1, 3],
    [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
      26, 27, 28, 29, 30, 31,
    ],
  ]

  func testErrors() throws {
    for var testSet in self.incorrectSets {
      XCTAssertThrowsError(try powerset(&testSet))
    }
  }

}
