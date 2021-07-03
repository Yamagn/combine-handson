import Combine
import Foundation

class YTDataApi {
    let host = "https://www.googleapis.com/youtube/v3/"
    let decoder = JSONDecoder()
    func SearchApi(query: String) -> AnyPublisher<Search, Error> {
        var components = URLComponents(string: host + "search")!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: "channel"),
            URLQueryItem(name: "key", value: "<YOUR API KEY>")
        ]

        guard let url = components.url else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: Search.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
