import XCTest

import func Functions.gray_code

final class Tests: XCTestCase {

  let expectedResults: [UInt32: UInt32] = [
    // decimal: gray
    0: 0,
    1: 1,
    2: 3,
    3: 2,
    4: 6,
    5: 7,
    6: 5,
    7: 4,
    8: 12,
    123: 70,
  ]

  func testMain() throws {
    for (n, expected) in self.expectedResults {
      let result = gray_code(n)
      XCTAssertEqual(result, expected)
    }
  }

}
