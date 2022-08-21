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
        let response: MusicResponse = try TestResourceLoader.load(from: "tr-top10-songs")
        
        XCTAssertEqual(response.id, "https://rss.applemarketingtools.com/api/v2/tr/music/most-played/10/songs.json")
        XCTAssertEqual(response.title, "Top Songs")
        XCTAssertEqual(response.copyright, "Copyright © 2022 Apple Inc. All rights reserved.")
        XCTAssertEqual(response.country, "tr")
        XCTAssertEqual(response.icon.absoluteString, "https://www.apple.com/favicon.ico")
        XCTAssertEqual(dateFormatter.string(from: response.updatedAt), "Sat, 20 Aug 2022 18:33:32 +0000")
        XCTAssertEqual(response.results.count, 10)
    }
    
    func test_music_videos() throws {
        let response: MusicResponse = try TestResourceLoader.load(from: "us-top10-music-videos")
        
        XCTAssertEqual(response.id, "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/music-videos.json")
        XCTAssertEqual(response.title, "Top Videos")
        XCTAssertEqual(response.copyright, "Copyright © 2022 Apple Inc. All rights reserved.")
        XCTAssertEqual(response.country, "us")
        XCTAssertEqual(response.icon.absoluteString, "https://www.apple.com/favicon.ico")
        XCTAssertEqual(dateFormatter.string(from: response.updatedAt), "Sun, 21 Aug 2022 01:52:55 +0000")
        XCTAssertEqual(response.results.count, 10)
    }
    
    func test_albums() throws {
        let response: MusicResponse = try TestResourceLoader.load(from: "gb-top10-albums")
        
        XCTAssertEqual(response.id, "https://rss.applemarketingtools.com/api/v2/gb/music/most-played/10/albums.json")
        XCTAssertEqual(response.title, "Top Albums")
        XCTAssertEqual(response.copyright, "Copyright © 2022 Apple Inc. All rights reserved.")
        XCTAssertEqual(response.country, "gb")
        XCTAssertEqual(response.icon.absoluteString, "https://www.apple.com/favicon.ico")
        XCTAssertEqual(dateFormatter.string(from: response.updatedAt), "Sun, 21 Aug 2022 01:58:25 +0000")
        XCTAssertEqual(response.results.count, 10)
    }
    
    func test_playlists() throws {
        let response: MusicResponse = try TestResourceLoader.load(from: "ie-top10-playlists")
        
        XCTAssertEqual(response.id, "https://rss.applemarketingtools.com/api/v2/ie/music/most-played/10/playlists.json")
        XCTAssertEqual(response.title, "Top Playlists")
        XCTAssertEqual(response.copyright, "Copyright © 2022 Apple Inc. All rights reserved.")
        XCTAssertEqual(response.country, "ie")
        XCTAssertEqual(response.icon.absoluteString, "https://www.apple.com/favicon.ico")
        XCTAssertEqual(dateFormatter.string(from: response.updatedAt), "Sun, 21 Aug 2022 02:00:51 +0000")
        XCTAssertEqual(response.results.count, 10)
    }
}
