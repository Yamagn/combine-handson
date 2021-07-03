import Combine
import Foundation

class YTDataApi {
    let host = "https://www.googleapis.com/youtube/v3/"
    let decoder = JSONDecoder()
    func searchApi(query: String) -> AnyPublisher<Search, Error> {
        var components = URLComponents(string: host + "search")!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: "channel"),
            URLQueryItem(name: "key", value: "<YOUR API KEY>")
        ]

        return sessionTask(components: components)
    }

    func playlistItemsApi(playlistId: String) -> AnyPublisher<PlaylistItem, Error> {
        var components = URLComponents(string: host + "playlistItems")!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "playlistId", value: playlistId),
            URLQueryItem(name: "maxResults", value: "20"),
            URLQueryItem(name: "key", value: "<YOUR API KEY>")
        ]
        return sessionTask(components: components)
    }

    private func sessionTask<T: Codable>(components: URLComponents) -> AnyPublisher<T, Error> {
        guard let url = components.url else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .map{ $0.data }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
