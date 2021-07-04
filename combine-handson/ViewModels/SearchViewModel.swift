import Foundation
import Combine

final class SearchViewModel: ObservableObject, Identifiable {
    @Published var dataSources: [Search.Snippet] = []
    @Published var query: String = ""
    private let api = YTDataApi()
    private var disposables = Set<AnyCancellable>()

    func  searchChannels(q: String) {
        api.searchApi(query: q)
            .map { response in
                response.items.map { $0.snippet }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                switch value {
                case .failure(let err):
                    print(err.localizedDescription)
                    self?.dataSources = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.dataSources = data
            })
            .store(in: &disposables)
    }
}
