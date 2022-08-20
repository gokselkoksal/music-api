import Combine

public struct MusicAPI {
    
    public var getMostPlayed: (MediaKind, CountryCode, MusicRequest.PageSize) -> AnyPublisher<MusicResponse, Error>
    
    public init(getMostPlayed: @escaping (MediaKind, CountryCode, MusicRequest.PageSize) -> AnyPublisher<MusicResponse, Error>) {
        self.getMostPlayed = getMostPlayed
    }
}
