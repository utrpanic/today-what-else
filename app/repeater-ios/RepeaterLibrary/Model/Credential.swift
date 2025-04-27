import Foundation
import SwiftData

@Model
public final class Credential {
  public var id: UUID
  public var email: String
  public var password: String
  public var label: String?
  public var createdAt: Date
  public var sortOrder: Int
  
  public init(email: String, password: String, label: String? = nil, sortOrder: Int = 0) {
    self.id = UUID()
    self.email = email
    self.password = password
    self.label = label
    self.createdAt = Date()
    self.sortOrder = sortOrder
  }
}