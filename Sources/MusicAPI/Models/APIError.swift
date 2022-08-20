import Foundation

public struct APIError: Error {
    
    public enum Reason {
        case emptyResponse
        case decodingFailure(Error)
    }
    
    public let response: RawResponse
    public let reason: Reason
}

public struct RawResponse {
    public let data: Data?
    public let error: Error?
    public let urlResponse: URLResponse?
}
