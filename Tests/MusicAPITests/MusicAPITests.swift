import XCTest
@testable import MusicAPI

final class music_apiTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MusicAPI().text, "Hello, World!")
    }
}
