import XCTest

import func Functions.multiplier

@testable import Ex01

final class MultiplierTests: XCTestCase {

  let expectedResults: [(UInt32, UInt32)] = [
    (0, 0),
    (2, 3),
    (UInt32.max / 2, 2),
    (UInt32.max / 2, UInt32.max / 2),
  ]

  func testMain() throws {
    for (a, b) in self.expectedResults {
      let result = multiplier(a, b)
      XCTAssertEqual(result, a &* b)
    }
  }

  func testRange() throws {
    for _ in 0...1000 {
      let a = UInt32.random(in: 0...UInt32.max)
      let b = UInt32.random(in: 0...UInt32.max)
      let result = multiplier(a, b)
      XCTAssertEqual(result, a &* b)
    }
  }

}
