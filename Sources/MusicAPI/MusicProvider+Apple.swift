import Foundation
import Combine

public extension MusicProvider {
    
    static func live() -> MusicProvider {
        MusicProvider { request in
            let urlRequest = URLRequest(url: request.url)
            let subject = PassthroughSubject<MusicResponse, Error>()

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                let response = RawResponse(data: data, error: error, urlResponse: response)
                if let error = response.error {
                    subject.send(completion: .failure(error))
                } else if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(MusicResponse.self, from: data)
                        subject.send(response)
                        subject.send(completion: .finished)
                    } catch {
                        let error = APIError(response: response, reason: .decodingFailure(error))
                        subject.send(completion: .failure(error))
                    }
                } else {
                    let error = APIError(response: response, reason: .emptyResponse)
                    subject.send(completion: .failure(error))
                }
            }
            return subject
                .receive(on: DispatchQueue.main)
                .handleEvents(
                    receiveCancel: { [weak task] in task?.cancel() },
                    receiveRequest: { [weak task] _ in task?.resume() }
                )
                .eraseToAnyPublisher()
        }
    }
}
