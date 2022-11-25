import XCTest

import func Functions.map
import func Functions.reverse_map

final class InverseFunctionTests: XCTestCase {

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
      // Test reverse map
      let (x, y) = try reverse_map(expectedN)
      XCTAssertEqual(x, expectedX)
      XCTAssertEqual(y, expectedY)
      // Test map
      let n = map(UInt16(x), UInt16(y))
      XCTAssertEqual(n, Float64(expectedN))
    }
  }

  func testRange() throws {
    let range = 0...UInt32.max
    for _ in 0...100000 {
      let expectedN = Float64(UInt32.random(in: range) / UInt32.max)
      let (x, y) = try reverse_map(expectedN)
      let n = map(x, y)
      XCTAssertEqual(n, expectedN)
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
