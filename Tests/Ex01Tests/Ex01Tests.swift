@testable import Ex01

import XCTest

final class Tests: XCTestCase {

    func testMain() throws {
        let result = multiplier(a: a, b: b)
        let expected = a * b
        XCTAssertEqual(result, expected)
    }

}