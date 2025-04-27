import Foundation
import SwiftUI
import RepeaterModel
import SwiftData

@MainActor
public class MessageViewModel: ObservableObject {
  @Published public var isAddingMessage = false
  @Published public var newMessage = ""
  @Published public var showCopiedAlert = false
  
  public var modelContext: ModelContext
  
  public init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  public func saveMessage() {
    let message = SavedMessage(content: newMessage)
    modelContext.insert(message)
    try? modelContext.save()
    newMessage = ""
    isAddingMessage = false
  }
  
  public func copyToClipboard(_ content: String) {
    UIPasteboard.general.string = content
    showCopiedAlert = true
    
    // Hide the alert after 2 seconds
    Task {
      try? await Task.sleep(for: .seconds(2))
      showCopiedAlert = false
    }
  }
  
  public func deleteMessage(_ message: SavedMessage) {
    modelContext.delete(message)
    try? modelContext.save()
  }
}
