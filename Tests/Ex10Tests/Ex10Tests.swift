import XCTest

import func Functions.map
import func Functions.reverse_map

final class Tests: XCTestCase {

  let expectedResults = [
    (0, 0, 0.0),
    (0, UInt16.max, 0.9999694828875292),
    (UInt16.max, 0, 0.9999847414437646),
    (UInt16.max, UInt16.max, 1.0),
    (1, 2, 1.1641532185403987e-09),
    (42, 4200, 0.004107142333897563),
    (UInt16.max / 2, UInt16.max / 2, 0.24999999982537702),
    (50000, 500, 0.5820883672177066),
  ]

  func testMain() throws {
    for (expectedX, expectedY, expectedN) in self.expectedResults {
      // Test map
      let n = map(UInt16(expectedX), UInt16(expectedY))
      XCTAssertEqual(n, Float64(expectedN))
      // Test reverse map
      let (x, y) = try reverse_map(n)
      XCTAssertEqual(x, expectedX)
      XCTAssertEqual(y, expectedY)
    }
  }

  func testRange() throws {
    let range = 0...UInt16.max
    for _ in 0...1000 {
      let expectedX = UInt16.random(in: range)
      let expectedY = UInt16.random(in: range)
      let n = map(expectedX, expectedY)
      let (x, y) = try reverse_map(n)
      XCTAssertEqual(x, expectedX)
      XCTAssertEqual(y, expectedY)
    }
  }

}
