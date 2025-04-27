import Foundation
import SwiftUI
import RepeaterModel
import SwiftData

@MainActor
public class MessageViewModel: ObservableObject {
  @Published public var isAddingMessage = false
  @Published public var isEditingMessage = false
  @Published public var newMessage = ""
  @Published public var editingMessage: SavedMessage?
  @Published public var showCopiedAlert = false
  @Published public var isEditMode = false
  
  public var modelContext: ModelContext
  
  public init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  public func saveMessage() {
    // Get the highest sort order value
    var descriptor = FetchDescriptor<SavedMessage>(sortBy: [SortDescriptor(\.sortOrder, order: .reverse)])
    descriptor.fetchLimit = 1
    
    let highestOrder = (try? modelContext.fetch(descriptor).first?.sortOrder) ?? -1
    
    if let editingMessage = editingMessage {
      // Update existing message
      editingMessage.content = newMessage
      self.editingMessage = nil
    } else {
      // Create new message
      let message = SavedMessage(content: newMessage, sortOrder: highestOrder + 1)
      modelContext.insert(message)
    }
    
    try? modelContext.save()
    newMessage = ""
    isAddingMessage = false
    isEditingMessage = false
  }
  
  public func startEditing(_ message: SavedMessage) {
    editingMessage = message
    newMessage = message.content
    isEditingMessage = true
  }
  
  public func cancelEditing() {
    editingMessage = nil
    newMessage = ""
    isEditingMessage = false
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
  
  public func moveMessages(from source: IndexSet, to destination: Int, messages: [SavedMessage]) {
    // Create a mutable copy of the array
    var items = messages
    
    // Perform the move within our temporary array
    items.move(fromOffsets: source, toOffset: destination)
    
    // Update the sortOrder of each item to match its new position
    for (index, message) in items.enumerated() {
      message.sortOrder = index
    }
    
    // Save the changes
    try? modelContext.save()
  }
  
  public func toggleEditMode() {
    isEditMode.toggle()
  }
}
