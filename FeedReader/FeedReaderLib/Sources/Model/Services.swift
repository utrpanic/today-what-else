import Combine
import Foundation

public typealias ResponseHandler = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkService {
    func fetchData(with request: URLRequest, handler: @escaping ResponseHandler) -> AnyCancellable
}

public protocol KeyValueService: AnyObject {
    subscript<T: Codable>(key key: String, type type: T.Type) -> T? { get set }
}

public struct Services {
    
    let networkService: NetworkService
    let keyValueService: KeyValueService
    
    public init(networkService: NetworkService, keyValueService: KeyValueService) {
        self.networkService = networkService
        self.keyValueService = keyValueService
    }
    
    public init() {
       self.init(networkService: URLSession.shared, keyValueService: UserDefaults.standard)
    }
}

extension URLSession: NetworkService {
    
   public func fetchData(with request: URLRequest, handler: @escaping ResponseHandler) -> AnyCancellable {
      let task = dataTask(with: request, completionHandler: handler)
      task.resume()
      return AnyCancellable(task)
   }
}

extension URLSessionDataTask: Cancellable {
    
}

extension UserDefaults: KeyValueService {
    
    public subscript<T: Codable>(key key: String, type type: T.Type) -> T? {
        get {
            self.data(forKey: key).flatMap { try? JSONDecoder().decode(T.self, from: $0) }
        }
        set {
            self.set(try? JSONEncoder().encode(newValue), forKey: key)
        }
    }
}
