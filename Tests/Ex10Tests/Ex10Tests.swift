import XCTest

import func Functions.map

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

  func testRange() throws {
    for (x, y, expected) in self.expectedResults {
      let results = map(UInt16(x), UInt16(y))
      XCTAssertEqual(results, Float64(expected))
    }
  }

}
