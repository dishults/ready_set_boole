import XCTest

@testable import Ex00

final class Tests: XCTestCase {

  func testMain() throws {
    let result = adder(a, b)
    let expected = a + b
    XCTAssertEqual(result, expected)
  }

  func testRange() throws {
    for _ in 1...50 {
      let a = UInt32.random(in: UInt32.min...UInt32(UInt16.max))
      let b = UInt32.random(in: UInt32.min...UInt32(UInt16.max))
      let result = adder(a, b)
      let expected = a + b
      XCTAssertEqual(result, expected)
    }
  }

}
