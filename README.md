# Apple Music RSS API

Simple Music API powered by [Apple's RSS Builder](https://rss.applemarketingtools.com/).

## Usage

```swift
let provider = MusicAPI.live()
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
