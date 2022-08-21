import Foundation

public struct CountryCode: Decodable, Equatable {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }
}

extension CountryCode: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

public extension CountryCode {
    static let turkey: CountryCode = "tr"
    static let ireland: CountryCode = "ie"
    static let unitedStates: CountryCode = "us"
    static let unitedKingdom: CountryCode = "gb"
}
