import Foundation

public struct MusicResponse {
    
    private enum RootCodingKeys: String, CodingKey {
        case feed
    }
    
    private enum FeedCodingKeys: String, CodingKey {
        case title
        case copyright
        case country
        case icon
        case updatedAt = "updated"
        case results
    }
    
    public let title: String
    public let copyright: String
    public let country: String
    public let icon: URL
    public let updatedAt: Date
    public let results: [Media]
    
    public init(title: String, copyright: String, country: String, icon: URL, updatedAt: Date, results: [Media]) {
        self.title = title
        self.copyright = copyright
        self.country = country
        self.icon = icon
        self.updatedAt = updatedAt
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: FeedCodingKeys.self, forKey: .feed)
        self.title = try container.decode(String.self, forKey: .title)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.country = try container.decode(String.self, forKey: .country)
        self.icon = try container.decode(URL.self, forKey: .icon)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.results = try container.decode([Media].self, forKey: .results)
    }
}

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
