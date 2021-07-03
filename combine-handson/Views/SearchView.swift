import SwiftUI
import Combine

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    init() {
        self.viewModel = SearchViewModel()
    }

    var body: some View {
        NavigationView {
            List {
                HStack(alignment: .center) {
                    TextField("チャンネル名", text: $viewModel.query, onCommit: {
                        viewModel.searchChannels(q: viewModel.query)
                    })
                }
                Section {
                    ForEach(0..<viewModel.dataSources.count, id: \.self) { row in
                        Text(viewModel.dataSources[row].title)
                    }
                }
            }
            .listStyle(GroupedListStyle()) 
            .navigationTitle("チャンネル検索")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
