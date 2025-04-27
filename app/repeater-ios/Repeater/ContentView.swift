import SwiftUI
import RepeaterModel
import RepeaterView
import RepeaterViewModel
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @StateObject private var messageViewModel: MessageViewModel
  @StateObject private var credentialViewModel: CredentialViewModel
  @State private var editMode = EditMode.inactive
  
  init() {
    // Initialize view models with temporary context - we'll update in onAppear
    let defaultContext = ModelContext(try! ModelContainer(for: SavedMessage.self, Credential.self))
    self._messageViewModel = StateObject(wrappedValue: MessageViewModel(modelContext: defaultContext))
    self._credentialViewModel = StateObject(wrappedValue: CredentialViewModel(modelContext: defaultContext))
  }
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading, spacing: 24) {
          // Slack Messages Section
          VStack(alignment: .leading) {
            SectionHeader(
              title: "Slack Messages",
              iconName: "message",
              action: { messageViewModel.isAddingMessage = true },
              editAction: { messageViewModel.toggleEditMode() },
              isEditMode: messageViewModel.isEditMode
            )
            
            MessageGridView(viewModel: messageViewModel)
              .frame(minHeight: 150) // Ensure there's some minimum height
          }
          
          Divider()
            .padding(.vertical, 8)
          
          // Login Credentials Section
          VStack(alignment: .leading) {
            SectionHeader(
              title: "Login Credentials",
              iconName: "key",
              action: { credentialViewModel.isAddingCredential = true },
              editAction: { credentialViewModel.toggleEditMode() },
              isEditMode: credentialViewModel.isEditMode
            )
            
            CredentialGridView(viewModel: credentialViewModel)
              .frame(minHeight: 150) // Ensure there's some minimum height
          }
        }
        .padding()
      }
      .navigationTitle("Repeater")
      .sheet(isPresented: $messageViewModel.isAddingMessage) {
        AddMessageView(viewModel: messageViewModel)
      }
      .sheet(isPresented: $messageViewModel.isEditingMessage) {
        EditMessageView(viewModel: messageViewModel)
      }
      .sheet(isPresented: $credentialViewModel.isAddingCredential) {
        AddCredentialView(viewModel: credentialViewModel)
      }
      .sheet(isPresented: $credentialViewModel.isEditingCredential) {
        EditCredentialView(viewModel: credentialViewModel)
      }
      .overlay {
        if messageViewModel.showCopiedAlert {
          CopiedAlert(message: "Copied to clipboard")
        } else if credentialViewModel.showCopiedAlert {
          CopiedAlert(message: "\(credentialViewModel.copiedItem) copied")
        }
      }
    }
    .onAppear {
      // Update view models to use the environment's modelContext
      messageViewModel.modelContext = modelContext
      credentialViewModel.modelContext = modelContext
    }
  }
}

struct SectionHeader: View {
  var title: String
  var iconName: String
  var action: () -> Void
  var editAction: () -> Void
  var isEditMode: Bool
  
  var body: some View {
    HStack {
      Label(title, systemImage: iconName)
        .font(.headline)
      
      Spacer()
      
      Button(action: editAction) {
        Text(isEditMode ? "Done" : "Reorder")
          .font(.subheadline)
      }
      .padding(.trailing, 8)
      
      if !isEditMode {
        Button(action: action) {
          Image(systemName: "plus.circle.fill")
            .font(.title3)
        }
      }
    }
    .padding(.bottom, 8)
  }
}

struct CopiedAlert: View {
  var message: String
  
  var body: some View {
    VStack {
      Spacer()
      Text(message)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .padding(.bottom)
    }
  }
}
