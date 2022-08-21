# music-api

Simple music API for sample apps.

## Usage

```swift
let provider = MusicAPI.apple()
let request = MusicRequest(country: "tr", kind: .songs, pageSize: .small)

cancellables += provider.getMostPlayedMusic(request).sink { [weak self] completion in
    switch completion {
    case .finished:
        break // success
    case .failure(let apiError):
        self?.handleError(apiError)
    }
    exp.fulfill()
} receiveValue: { [weak self] response in
    self?.updateTitle(response.title)
    self?.updateResults(response.results) // [Media]
}
```
