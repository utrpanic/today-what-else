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
    
    var task: AnyCancellable?
    
    let services: Services
    
    public init(services: Services) {
        self.services = services
        self.readingStatuses = services.keyValueService[key: "readingStatuses", type: [URL: Bool].self] ?? [:]
        self.reload()
    }
    
    public func reload() {
        let request = URLRequest(url: URL(string: "https://www.cocoawithlove.com/feed.json")!)
        let service = self.services.networkService
        self.task = service.fetchData(with: request) { data, response, error in
            do {
                if let error = error { throw error }
                let feed = try JSONDecoder().decode(Feed.self, from: data ?? Data())
                DispatchQueue.main.async { self.feed = feed }
            } catch {
                DispatchQueue.main.async { self.error = IdentifiableError(underlying: error) }
            }
        }
    }
    
    public func setReading(_ value: Bool, url: URL) {
        var statuses = self.readingStatuses
        statuses[url] = value
        self.readingStatuses = statuses
        self.services.keyValueService[key: "readingStatuses", type: [URL: Bool].self] = self.readingStatuses
    }
}
