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
    
    @Published var feed: Feed?
    @Published var readingStatuses: [URL: Bool]
    
    private var task: URLSessionDataTask?
    
    init() {
        self.readingStatuses = UserDefaults.standard.data(forKey: "readingStatuses")
            .flatMap { try? JSONDecoder().decode([URL: Bool].self, from: $0) } ?? [:]
        let request = URLRequest(url: URL(string: "https://www.cocoawithlove.com/feed.json")!)
        self.task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error { throw error }
                let feed = try JSONDecoder().decode(Feed.self, from: data ?? Data())
                DispatchQueue.main.async { self.feed = feed }
            } catch {
                // do nothing.
            }
        }
        self.task?.resume()
    }
    
    func setReading(_ value: Bool, url: URL) {
        self.readingStatuses[url] = value
        let newData = try? JSONEncoder().encode(self.readingStatuses)
        UserDefaults.standard.set(newData, forKey: "readingStatuses")
    }
}
