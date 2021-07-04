import Foundation

struct Search: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let snippet: Snippet
    }

    struct Snippet: Codable {
        let channelId: String
        let title: String
    }
}

