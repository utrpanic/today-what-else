import Foundation
import SwiftData

@Model
public final class SavedMessage {
  public var id: UUID
  public var content: String
  public var createdAt: Date
  public var sortOrder: Int
  
  public init(content: String, sortOrder: Int = 0) {
    self.id = UUID()
    self.content = content
    self.createdAt = Date()
    self.sortOrder = sortOrder
  }
}
