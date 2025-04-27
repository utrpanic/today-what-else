import Foundation
import SwiftUI
import SwiftData
import RepeaterModel

@MainActor
public class CredentialViewModel: ObservableObject {
  @Published public var isAddingCredential = false
  @Published public var newEmail = ""
  @Published public var newPassword = ""
  @Published public var newLabel = ""
  @Published public var showCopiedAlert = false
  @Published public var copiedItem = ""
  
  public var modelContext: ModelContext
  
  public init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  public func saveCredential() {
    let credential = Credential(
      email: newEmail,
      password: newPassword,
      label: newLabel.isEmpty ? nil : newLabel
    )
    modelContext.insert(credential)
    try? modelContext.save()
    
    // Reset form
    newEmail = ""
    newPassword = ""
    newLabel = ""
    isAddingCredential = false
  }
  
  public func copyToClipboard(_ content: String, itemName: String) {
    UIPasteboard.general.string = content
    copiedItem = itemName
    showCopiedAlert = true
    
    // Hide the alert after 2 seconds
    Task {
      try? await Task.sleep(for: .seconds(2))
      showCopiedAlert = false
    }
  }
  
  public func deleteCredential(_ credential: Credential) {
    modelContext.delete(credential)
    try? modelContext.save()
  }
}