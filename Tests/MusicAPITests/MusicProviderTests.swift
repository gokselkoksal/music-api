import XCTest
import MusicAPI
import Combine

final class MusicProviderTests: XCTestCase {
    
    func testExample() throws {
        // Given
        let provider = MusicProvider.apple()
        var didFinish: Bool = false
        var error: Error?
        var response: MusicResponse?
        
        // When
        let exp = expectation(description: "should receive response")
        let pageSize = MusicRequest.PageSize.small
        let request = MusicRequest(country: "tr", kind: .songs, pageSize: pageSize)
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
        
        // Then
        XCTAssertTrue(didFinish)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        let results = try XCTUnwrap(response).results
        XCTAssertLessThanOrEqual(results.count, pageSize.rawValue)
        
        observer.cancel()
    }
}
