import Foundation
import XCTest
import MusicAPI

final class MediaTests: XCTestCase {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // 2022-07-29
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .init(secondsFromGMT: 0)
        formatter.locale = .init(identifier: "en")
        return formatter
    }()

    func test_song() throws {
        let song: Media = try TestResourceLoader.load(from: "song")
        
        XCTAssertEqual(song.id, "1635429608")
        XCTAssertEqual(song.name, "Ara")
        XCTAssertEqual(song.releaseDate.flatMap({ dateFormatter.string(from: $0) }), "2022-07-29")
        XCTAssertEqual(song.kind, .songs)
        XCTAssertEqual(song.artist.name, "Zeynep Bastık")
        XCTAssertEqual(song.artist.id, "935766494")
        XCTAssertEqual(song.artist.url?.absoluteString, "https://music.apple.com/tr/artist/zeynep-bast%C4%B1k/935766494")
        XCTAssertEqual(song.artworkURL.absoluteString, "https://is5-ssl.mzstatic.com/image/thumb/Music122/v4/a9/11/2a/a9112afe-d433-a622-a8e4-81d5c83f7c83/cover.jpg/100x100bb.jpg")
        XCTAssertEqual(song.genres, [
            Genre(id: "14", name: "Pop", url: URL(string: "https://itunes.apple.com/tr/genre/id14")),
            Genre(id: "34", name: "Music", url: URL(string: "https://itunes.apple.com/tr/genre/id34")),
        ])
        XCTAssertEqual(song.url.absoluteString, "https://music.apple.com/tr/album/ara/1635429603?i=1635429608")
    }
    
    func test_music_video() throws {
        let musicVideo: Media = try TestResourceLoader.load(from: "music-video")
        
        XCTAssertEqual(musicVideo.id, "1634841222")
        XCTAssertEqual(musicVideo.name, "2 Million Up")
        XCTAssertEqual(musicVideo.releaseDate.flatMap({ dateFormatter.string(from: $0) }), "2022-07-15")
        XCTAssertEqual(musicVideo.kind, .musicVideos)
        XCTAssertEqual(musicVideo.artist.name, "Peezy")
        XCTAssertEqual(musicVideo.artist.id, "1433819455")
        XCTAssertEqual(musicVideo.artist.url?.absoluteString, "https://music.apple.com/us/artist/peezy/1433819455")
        XCTAssertEqual(musicVideo.contentAdvisoryRating, "Explict")
        XCTAssertEqual(musicVideo.artworkURL.absoluteString, "https://is1-ssl.mzstatic.com/image/thumb/Video122/v4/c6/a9/e5/c6a9e520-e659-8a8c-e04a-33f7713abb51/194690903021_cover.jpg/100x56mv.jpg")
        XCTAssertEqual(musicVideo.genres, [Genre(id: nil, name: "Hip-Hop/Rap", url: nil)])
        XCTAssertEqual(musicVideo.url.absoluteString, "https://music.apple.com/us/music-video/2-million-up/1634841222")
    }
    
    func test_album() throws {
        let album: Media = try TestResourceLoader.load(from: "album")
        
        XCTAssertEqual(album.artist.name, "Beyoncé")
        XCTAssertEqual(album.id, "1630005298")
        XCTAssertEqual(album.name, "RENAISSANCE")
        XCTAssertEqual(album.releaseDate.flatMap({ dateFormatter.string(from: $0) }), "2022-07-29")
        XCTAssertEqual(album.kind, .albums)
        XCTAssertEqual(album.artist.id, "1419227")
        XCTAssertEqual(album.artist.url?.absoluteString, "https://music.apple.com/gb/artist/beyonc%C3%A9/1419227")
        XCTAssertEqual(album.contentAdvisoryRating, "Explict")
        XCTAssertEqual(album.artworkURL.absoluteString, "https://is5-ssl.mzstatic.com/image/thumb/Music112/v4/05/05/f3/0505f338-9873-feb4-af7f-27a470405e5f/196589246974.jpg/100x100bb.jpg")
        XCTAssertEqual(album.genres, [
            Genre(id: "14", name: "Pop", url: URL(string: "https://itunes.apple.com/gb/genre/id14")),
            Genre(id: "34", name: "Music", url: URL(string: "https://itunes.apple.com/gb/genre/id34")),
        ])
        XCTAssertEqual(album.url.absoluteString, "https://music.apple.com/gb/album/renaissance/1630005298")
    }
    
    func test_playlist() throws {
        let playlist: Media = try TestResourceLoader.load(from: "playlist")
        
        XCTAssertEqual(playlist.id, "pl.f4d106fed2bd41149aaacabb233eb5eb")
        XCTAssertEqual(playlist.name, "Today’s Hits")
        XCTAssertEqual(playlist.kind, .playlists)
        XCTAssertNil(playlist.artist.name)
        XCTAssertNil(playlist.artist.id)
        XCTAssertNil(playlist.artist.url)
        XCTAssertEqual(playlist.artworkURL.absoluteString, "https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/8f/34/51/8f3451e1-57f9-f445-f98e-334e42c849b9/44355f58-e124-44a9-afa4-988bc60f313b.png/100x100SC.DN01.jpg?l=en-GB")
        XCTAssertEqual(playlist.genres, [])
        XCTAssertEqual(playlist.url.absoluteString, "https://music.apple.com/ie/playlist/todays-hits/pl.f4d106fed2bd41149aaacabb233eb5eb")
    }
}
