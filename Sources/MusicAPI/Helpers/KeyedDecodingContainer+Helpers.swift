import Foundation

extension KeyedDecodingContainer {
    
    func decodeDate(using formatter: DateFormatter, forKey key: Key) throws -> Date {
        let dateString = try decode(String.self, forKey: key)
        return try convertDateString(dateString, using: formatter, forKey: key)
    }
    
    func decodeDateIfPresent(using formatter: DateFormatter, forKey key: Key) throws -> Date? {
        guard let dateString = try decodeIfPresent(String.self, forKey: key) else { return nil }
        return try convertDateString(dateString, using: formatter, forKey: key)
    }
    
    private func convertDateString(_ dateString: String, using formatter: DateFormatter, forKey key: Key) throws -> Date {
        if let date = formatter.date(from: dateString) {
            return date
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Expected date in format <\(formatter.dateFormat ?? "nil")>, got <\(dateString)>"
            )
        }
    }
}
