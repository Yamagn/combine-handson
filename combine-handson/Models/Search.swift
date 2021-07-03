import Foundation

struct Search: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let snippet: Snippet
    }

    struct Snippet: Codable {
        let channelId: String
        let title: String
        let thumbnails: Thumbnail
    }

    struct Thumbnail: Codable {
        let high: High
    }

    struct High: Codable {
        let url: String
    }
}

