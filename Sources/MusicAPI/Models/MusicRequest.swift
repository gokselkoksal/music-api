import Foundation

public struct CountryCode: ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

public enum MediaKind: String, Decodable {
    case albums = "albums"
    case musicVideos = "music-videos"
    case playlists = "playlists"
    case songs = "songs"
}

public struct MusicRequest {
    
    public enum PageSize: Int {
        /// 10 items
        case small = 10
        
        /// 25 items
        case medium = 25
        
        /// 50 items
        case large = 50
    }
    
    public var country: CountryCode
    public var kind: MediaKind
    public var pageSize: PageSize
    
    public init(country: CountryCode, kind: MediaKind, pageSize: MusicRequest.PageSize) {
        self.country = country
        self.kind = kind
        self.pageSize = pageSize
    }
}

public extension MusicRequest {
    var url: URL {
        var url = URL(string: "https://rss.applemarketingtools.com/api/v2/")!
        url.appendPathComponent(country.rawValue)
        url.appendPathComponent("music")
        url.appendPathComponent("most-played")
        url.appendPathComponent(String(pageSize.rawValue))
        url.appendPathComponent(kind.rawValue)
        url.appendPathExtension("json")
        return url
    }
}
