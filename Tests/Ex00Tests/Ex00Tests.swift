@testable import Ex00

import XCTest

final class Tests: XCTestCase {

    func testMain() throws {
        let result = adder(a: a, b: b)
        let expected = a + b
        XCTAssertEqual(result, expected)
    }

}
