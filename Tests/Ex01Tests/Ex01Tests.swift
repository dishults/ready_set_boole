import XCTest

@testable import Ex01

final class Tests: XCTestCase {

  func testMain() throws {
    let result = multiplier(a, b)
    let expected = a * b
    XCTAssertEqual(result, expected)
  }

  func testRange() throws {
    for a: UInt32 in 1...9 {
      for b: UInt32 in a...9 {
        let result = multiplier(a, b)
        let expected = a * b
        XCTAssertEqual(result, expected)
      }
    }
  }

}
