import Foundation
import XCTest

final class TestResourceLoader {
    static func load<T: Decodable>(
        _ type: T.Type = T.self,
        from fileName: String,
        decoder: JSONDecoder = JSONDecoder(),
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T {
        let url = try XCTUnwrap(Bundle.module.url(forResource: fileName, withExtension: "json"), file: file, line: line)
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
}
