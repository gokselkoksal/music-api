import XCTest
import MusicAPI
import Combine

final class MusicProviderTests: XCTestCase {
    
    func test_songs() throws {
        try assertRequest(for: .songs, country: .turkey)
    }
    
    func test_music_videos() throws {
        try assertRequest(for: .songs, country: .unitedStates)
    }
    
    func test_albums() throws {
        try assertRequest(for: .albums, country: .unitedKingdom)
    }
    
    func test_playlists() throws {
        try assertRequest(for: .playlists, country: .ireland)
    }
    
    private func assertRequest(for kind: MediaKind, country: CountryCode, file: StaticString = #file, line: UInt = #line) throws {
        // Given a music provider
        let provider = MusicProvider.apple()
        var didFinish: Bool = false
        var error: Error?
        var response: MusicResponse?
        
        // When top media are requested
        let exp = expectation(description: "should receive response")
        let pageSize = MusicRequest.PageSize.large
        let request = MusicRequest(country: country, kind: kind, pageSize: pageSize)
        let observer = provider.getMostPlayedMusic(request).sink { completion in
            switch completion {
            case .finished:
                didFinish = true
            case .failure(let apiError):
                error = apiError
            }
            exp.fulfill()
        } receiveValue: { value in
            response = value
        }
        wait(for: [exp], timeout: 3.0)
        
        // Then expect to receive a response
        XCTAssertTrue(didFinish, file: file, line: line)
        XCTAssertNil(error, file: file, line: line)
        XCTAssertNotNil(response, file: file, line: line)
        let results = try XCTUnwrap(response, file: file, line: line).results
        XCTAssertLessThanOrEqual(results.count, pageSize.rawValue, file: file, line: line)
        
        observer.cancel()
    }
}
