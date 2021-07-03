import Foundation

struct PlaylistItem: Codable {
    let items: [Item]

    struct Item: Codable {
        let snippet: Snippet
    }

    struct Snippet: Codable {
        let title: String
        let resourceId: ResourceId

        struct ResourceId: Codable {
            let videoId: String
        }
    }
}
