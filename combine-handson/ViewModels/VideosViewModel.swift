import Foundation
import Combine

final class VideosViewModel: ObservableObject {
    @Published var videos: [PlaylistItem.Snippet] = []
    private let api = YTDataApi()
    private var disposables = Set<AnyCancellable>()

    func fetchUploadVideos(channelId: String) {
        guard let range = channelId.range(of: "UC") else { return }
        let playlistId: String = channelId.replacingCharacters(in: range, with: "UU")
        api.playlistItemsApi(playlistId: playlistId)
            .map { response in
                response.items.map { item in
                    item.snippet
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let err):
                    print(err)
                    self.videos = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.videos = data
            })
            .store(in: &disposables)
    }
}
