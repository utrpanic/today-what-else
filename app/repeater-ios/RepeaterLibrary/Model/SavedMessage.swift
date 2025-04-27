import Foundation

public struct SavedMessage: Identifiable, Codable, Equatable {
  public var id = UUID()
  public var content: String
  public var createdAt = Date()
  
  public init(content: String) {
    self.content = content
  }
  
  public static func == (lhs: SavedMessage, rhs: SavedMessage) -> Bool {
    lhs.id == rhs.id
  }
}
