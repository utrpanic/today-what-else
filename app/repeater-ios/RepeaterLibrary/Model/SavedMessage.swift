import Foundation
import SwiftData

@Model
public final class SavedMessage {
  public var id: UUID
  public var content: String
  public var createdAt: Date
  
  public init(content: String) {
    self.id = UUID()
    self.content = content
    self.createdAt = Date()
  }
}
