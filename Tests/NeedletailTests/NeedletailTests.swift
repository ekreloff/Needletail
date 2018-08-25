import XCTest
@testable import Needletail

final class NeedletailTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Needletail().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
