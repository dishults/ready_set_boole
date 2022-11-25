import XCTest

import func Functions.adder

@testable import Ex00

final class AdderTests: XCTestCase {

  let expectedResults: [(UInt32, UInt32)] = [
    (0, 0),
    (1, 2),
    (UInt32.max / 2, UInt32.max / 2),
    (UInt32.max / 2 + 1, UInt32.max / 2 + 1),
  ]

  func testMain() throws {
    for (a, b) in self.expectedResults {
      let result = adder(a, b)
      XCTAssertEqual(result, a &+ b)
    }
  }

  func testRange() throws {
    for _ in 0...1000 {
      let a = UInt32.random(in: 0...UInt32.max)
      let b = UInt32.random(in: 0...UInt32.max)
      let result = adder(a, b)
      XCTAssertEqual(result, a &+ b)
    }
  }

}
