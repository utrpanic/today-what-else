import Foundation
import SwiftUI
import RepeaterModel

@MainActor
public class MessageViewModel: ObservableObject {
  @Published public var savedMessages: [SavedMessage] = []
  @Published public var isAddingMessage = false
  @Published public var newMessage = ""
  @Published public var showCopiedAlert = false
  
  private let saveKey = "SavedMessages"
  
  public init() {
    loadMessages()
  }
  
  public func saveMessage() {
    let message = SavedMessage(content: newMessage)
    savedMessages.append(message)
    persistMessages()
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
  
  public func deleteMessage(at offsets: IndexSet) {
    savedMessages.remove(atOffsets: offsets)
    persistMessages()
  }
  
  public func moveMessage(from source: IndexSet, to destination: Int) {
    savedMessages.move(fromOffsets: source, toOffset: destination)
    persistMessages()
  }
  
  private func persistMessages() {
    if let encoded = try? JSONEncoder().encode(savedMessages) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }
  }
  
  private func loadMessages() {
    if let savedData = UserDefaults.standard.data(forKey: saveKey),
       let decoded = try? JSONDecoder().decode([SavedMessage].self, from: savedData) {
      savedMessages = decoded
    }
  }
}
