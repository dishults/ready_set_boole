import XCTest

import func Functions.gray_code

final class Tests: XCTestCase {

  let decimalToGray: [UInt32: UInt32] = [
    0: 0,
    1: 1,
    2: 3,
    3: 2,
    4: 6,
    5: 7,
    6: 5,
    7: 4,
    8: 12,
  ]

  func testRange() throws {
    for (n, expected) in self.decimalToGray {
      let result = gray_code(n)
      XCTAssertEqual(result, expected)
    }
  }

}
