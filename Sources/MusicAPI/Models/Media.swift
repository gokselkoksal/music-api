import Foundation

public struct Media: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case artistName
        case name
        case releaseDate
        case kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkURL = "artworkUrl100"
        case genres
        case url
        case contentAdvisoryRating
    }
    
    public let id: String
    public let name: String
    public let releaseDate: Date?
    public let kind: MediaKind
    public let artist: Artist
    public let artworkURL: URL
    public let genres: [Genre]
    public let url: URL
    public let contentAdvisoryRating: String?
    
    public init(id: String, name: String, releaseDate: Date?, kind: MediaKind, artist: Artist, artworkURL: URL, genres: [Genre], url: URL, contentAdvisoryRating: String?) {
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
        self.kind = kind
        self.artist = artist
        self.artworkURL = artworkURL
        self.genres = genres
        self.url = url
        self.contentAdvisoryRating = contentAdvisoryRating
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.releaseDate = try container.decodeDateIfPresent(using: Self.dateFormatter, forKey: .releaseDate)
        self.kind = try container.decode(MediaKind.self, forKey: .kind)
        self.artist = Artist(
            id: try container.decodeIfPresent(String.self, forKey: .artistID),
            name: try container.decodeIfPresent(String.self, forKey: .artistName),
            url: try container.decodeIfPresent(URL.self, forKey: .artistURL)
        )
        self.artworkURL = try container.decode(URL.self, forKey: .artworkURL)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
        self.url = try container.decode(URL.self, forKey: .url)
        self.contentAdvisoryRating = try container.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // 2022-07-29
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .init(secondsFromGMT: 0)
        formatter.locale = .init(identifier: "en")
        return formatter
    }()
}

public struct Artist: Equatable {
    public let id: String?
    public let name: String?
    public let url: URL?
}

public struct Genre: Equatable, Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "genreId"
        case name
        case url
    }
    
    public let id: String?
    public let name: String
    public let url: URL?
    
    public init(id: String?, name: String, url: URL?) {
        self.id = id
        self.name = name
        self.url = url
    }
}
