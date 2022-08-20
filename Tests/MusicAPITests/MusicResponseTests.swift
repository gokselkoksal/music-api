import Foundation
import XCTest
import MusicAPI

final class MusicResponseTests: XCTestCase {
    
    private let decoder = JSONDecoder()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // Sat, 20 Aug 2022 17:46:30 +0000
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        formatter.timeZone = .init(secondsFromGMT: 0)
        formatter.locale = .init(identifier: "en")
        return formatter
    }()
    
    func test_songs() throws {
        let response = try loadResponse("turkey-top-10-songs")
        
        XCTAssertEqual(response.title, "Top Songs")
        XCTAssertEqual(response.copyright, "Copyright © 2022 Apple Inc. All rights reserved.")
        XCTAssertEqual(response.country, "tr")
        XCTAssertEqual(response.icon.absoluteString, "https://www.apple.com/favicon.ico")
        XCTAssertEqual(dateFormatter.string(from: response.updatedAt), "Sat, 20 Aug 2022 18:33:32 +0000")
        XCTAssertEqual(response.results.count, 10)
    }
    
    private func loadResponse(_ fileName: String) throws -> MusicResponse {
        let url = try XCTUnwrap(Bundle.module.url(forResource: fileName, withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: url))
        return try decoder.decode(MusicResponse.self, from: data)
    }
}
