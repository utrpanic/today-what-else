import Foundation
import SwiftUI
import SwiftData
import RepeaterModel

@MainActor
public class CredentialViewModel: ObservableObject {
  @Published public var isAddingCredential = false
  @Published public var isEditingCredential = false
  @Published public var newEmail = ""
  @Published public var newPassword = ""
  @Published public var newLabel = ""
  @Published public var showCopiedAlert = false
  @Published public var copiedItem = ""
  @Published public var isEditMode = false
  @Published public var editingCredential: Credential?
  
  public var modelContext: ModelContext
  
  public init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  public func saveCredential() {
    // Get the highest sort order value
    var descriptor = FetchDescriptor<Credential>(sortBy: [SortDescriptor(\.sortOrder, order: .reverse)])
    descriptor.fetchLimit = 1
    
    let highestOrder = (try? modelContext.fetch(descriptor).first?.sortOrder) ?? -1
    
    if let editingCredential = editingCredential {
      // Update existing credential
      editingCredential.email = newEmail
      editingCredential.password = newPassword
      editingCredential.label = newLabel.isEmpty ? nil : newLabel
      self.editingCredential = nil
    } else {
      // Create new credential
      let credential = Credential(
        email: newEmail,
        password: newPassword,
        label: newLabel.isEmpty ? nil : newLabel,
        sortOrder: highestOrder + 1
      )
      modelContext.insert(credential)
    }
    
    try? modelContext.save()
    
    // Reset form
    newEmail = ""
    newPassword = ""
    newLabel = ""
    isAddingCredential = false
    isEditingCredential = false
  }
  
  public func startEditing(_ credential: Credential) {
    editingCredential = credential
    newEmail = credential.email
    newPassword = credential.password
    newLabel = credential.label ?? ""
    isEditingCredential = true
  }
  
  public func cancelEditing() {
    editingCredential = nil
    newEmail = ""
    newPassword = ""
    newLabel = ""
    isEditingCredential = false
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
  
  public func moveCredentials(from source: IndexSet, to destination: Int, credentials: [Credential]) {
    // Create a mutable copy of the array
    var items = credentials
    
    // Perform the move within our temporary array
    items.move(fromOffsets: source, toOffset: destination)
    
    // Update the sortOrder of each item to match its new position
    for (index, credential) in items.enumerated() {
      credential.sortOrder = index
    }
    
    // Save the changes
    try? modelContext.save()
  }
  
  public func toggleEditMode() {
    isEditMode.toggle()
  }
}
