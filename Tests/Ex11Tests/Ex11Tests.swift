import XCTest

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

  func testRange() throws {
    for (expectedX, expectedY, n) in self.expectedResults {
      let (x, y) = try reverse_map(n)
      XCTAssertEqual(x, expectedX)
      XCTAssertEqual(y, expectedY)
    }
  }

  let incorrectTestCases = [
    (-0.5),
    (-1.0),
    (1.5),
    (2.0),
  ]

  func testErrors() throws {
    for n in self.incorrectTestCases {
      XCTAssertThrowsError(try reverse_map(n))
    }
  }

}
