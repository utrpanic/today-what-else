import Foundation
import Combine

import Toolbox

public struct Feed: Codable {
    public let items: [Article]
}

public struct Article: Codable {
    
    public let url: URL
    public let title: String
    public let content: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case content = "content_html"
    }
}

public class Model: ObservableObject {
    
    @Published public private(set) var feed: Feed?
    @Published public var error: IdentifiableError?
    @Published public private(set) var readingStatuses: [URL: Bool]
    
    private enum Key: String {
        case readingStatuses
    }
    
    private var task: URLSessionDataTask?
    
    public init() {
        self.readingStatuses = UserDefaults.standard.data(forKey: Key.readingStatuses.rawValue )
            .flatMap { try? JSONDecoder().decode([URL: Bool].self, from: $0) } ?? [:]
        self.reload()
    }
    
    public func reload() {
        let request = URLRequest(url: URL(string: "https://www.cocoawithlove.com/feed.json")!)
        self.task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error { throw error }
                let feed = try JSONDecoder().decode(Feed.self, from: data ?? Data())
                DispatchQueue.main.async { self.feed = feed }
            } catch {
                DispatchQueue.main.async { self.error = IdentifiableError(underlying: error) }
            }
        }
        self.task?.resume()
    }
    
    public func setReading(_ value: Bool, url: URL) {
        self.readingStatuses[url] = value
        let newData = try? JSONEncoder().encode(self.readingStatuses)
        UserDefaults.standard.set(newData, forKey: Key.readingStatuses.rawValue)
    }
}
