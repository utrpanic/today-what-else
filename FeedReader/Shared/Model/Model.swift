import Foundation
import Combine

struct Feed: Codable {
    let items: [Article]
}

struct Article: Codable {
    
    let url: URL
    let title: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case content = "content_html"
    }
}

class Model: ObservableObject {
    
    @Published var feed: Feed? = Feed(
        items: [
            Article(url: URL(string: "mock://x/a1.html")!, title: "Article1", content: "One"),
            Article(url: URL(string: "mock://x/a2.html")!, title: "Article2", content: "Two"),
            Article(url: URL(string: "mock://x/a3.html")!, title: "Article3", content: "Three")
        ]
    )
}
