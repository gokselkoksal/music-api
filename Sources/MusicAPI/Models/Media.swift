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
    }
    
    public let id: String
    public let artistName: String?
    public let name: String
    public let releaseDate: Date
    public let kind: MediaKind
    public let artistID: String
    public let artistURL: URL
    public let artworkURL: URL
    public let genres: [Genre]
    public let url: URL
    
    public init(id: String, artistName: String?, name: String, releaseDate: Date, kind: MediaKind, artistID: String, artistURL: URL, artworkURL: URL, genres: [Genre], url: URL) {
        self.id = id
        self.artistName = artistName
        self.name = name
        self.releaseDate = releaseDate
        self.kind = kind
        self.artistID = artistID
        self.artistURL = artistURL
        self.artworkURL = artworkURL
        self.genres = genres
        self.url = url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        self.name = try container.decode(String.self, forKey: .name)
        self.releaseDate = try container.decodeDate(using: Self.dateFormatter, forKey: .releaseDate)
        self.kind = try container.decode(MediaKind.self, forKey: .kind)
        self.artistID = try container.decode(String.self, forKey: .artistID)
        self.artistURL = try container.decode(URL.self, forKey: .artistURL)
        self.artworkURL = try container.decode(URL.self, forKey: .artworkURL)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.url = try container.decode(URL.self, forKey: .url)
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

public struct Genre: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "genreId"
        case name
        case url
    }
    
    public let id: String
    public let name: String
    public let url: URL
    
    public init(id: String, name: String, url: URL) {
        self.id = id
        self.name = name
        self.url = url
    }
}
