import Foundation
import Combine

public struct MusicProvider {
    
    public var getMostPlayedMusic: (MusicRequest) -> AnyPublisher<MusicResponse, Error>
    
    public init(getMostPlayedMusic: @escaping (MusicRequest) -> AnyPublisher<MusicResponse, Error>) {
        self.getMostPlayedMusic = getMostPlayedMusic
    }
}
