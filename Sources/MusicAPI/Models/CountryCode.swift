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

public extension CountryCode {
    static let unitedStates: CountryCode = "us"
    static let unitedKingdom: CountryCode = "gb"
    static let turkey: CountryCode = "tr"
}
