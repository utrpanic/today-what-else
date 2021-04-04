import Foundation

public struct IdentifiableError: Error, Identifiable {
    
    public let underlying: Error
    
    public var id: String {
        return self.localizedDescription
    }
    public var localizedDescription: String {
        return self.underlying.localizedDescription
    }
    
    public init(underlying: Error) {
        self.underlying = underlying
    }
}
