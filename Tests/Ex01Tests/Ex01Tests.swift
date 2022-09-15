import XCTest

@testable import Ex01

final class Tests: XCTestCase {

  func testMain() throws {
    let result = multiplier(a, b)
    let expected = a * b
    XCTAssertEqual(result, expected)
  }

}
