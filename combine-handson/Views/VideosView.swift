import SwiftUI

struct VideosView: View {
    private var channelId = ""
    private var channelTitle = ""
    @ObservedObject private var viewModel = VideosViewModel()

    init(channelId: String, channelTitle: String) {
        self.channelId = channelId
        self.channelTitle = channelTitle
    }

    var body: some View {
        List {
            ForEach(0..<viewModel.videos.count, id: \.self) { row in
                Button(action: {
                    if let url = URL(string: "https://youtube.com/watch?v=" + viewModel.videos[row].resourceId.videoId) {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text(viewModel.videos[row].title)
                })
            }
        }
        .navigationTitle(channelTitle)
        .onAppear {
            viewModel.fetchUploadVideos(channelId: channelId)
        }
    }
}

struct VideosView_Previews: PreviewProvider {
    static var previews: some View {
        VideosView(channelId: "", channelTitle: "")
    }
}
