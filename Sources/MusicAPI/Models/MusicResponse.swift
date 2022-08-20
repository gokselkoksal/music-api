import Foundation

public struct MusicResponse: Decodable {
    
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
    public let copyright: String?
    public let country: CountryCode
    public let icon: URL
    public let updatedAt: Date
    public let results: [Media]
    
    public init(title: String, copyright: String?, country: CountryCode, icon: URL, updatedAt: Date, results: [Media]) {
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
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.country = try container.decode(CountryCode.self, forKey: .country)
        self.icon = try container.decode(URL.self, forKey: .icon)
        self.updatedAt = try container.decodeDate(using: Self.dateFormatter, forKey: .updatedAt)
        self.results = try container.decode([Media].self, forKey: .results)
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // Sat, 20 Aug 2022 17:46:30 +0000
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        formatter.timeZone = .init(secondsFromGMT: 0)
        formatter.locale = .init(identifier: "en")
        return formatter
    }()
}
