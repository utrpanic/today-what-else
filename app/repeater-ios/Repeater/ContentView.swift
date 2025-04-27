import SwiftUI
import RepeaterModel
import RepeaterView
import RepeaterViewModel
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @StateObject private var messageViewModel: MessageViewModel
  @StateObject private var credentialViewModel: CredentialViewModel
  @State private var selectedTab = 0
  
  init() {
    // Initialize view models with temporary context - we'll update in onAppear
    let defaultContext = ModelContext(try! ModelContainer(for: SavedMessage.self, Credential.self))
    self._messageViewModel = StateObject(wrappedValue: MessageViewModel(modelContext: defaultContext))
    self._credentialViewModel = StateObject(wrappedValue: CredentialViewModel(modelContext: defaultContext))
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      // Slack Messages Tab
      NavigationStack {
        MessageGridView(viewModel: messageViewModel)
          .navigationTitle("Slack Messages")
          .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
              Button {
                messageViewModel.isAddingMessage = true
              } label: {
                Image(systemName: "plus")
              }
            }
          }
          .sheet(isPresented: $messageViewModel.isAddingMessage) {
            AddMessageView(viewModel: messageViewModel)
          }
          .overlay {
            if messageViewModel.showCopiedAlert {
              CopiedAlert(message: "Copied to clipboard")
            }
          }
      }
      .tabItem {
        Label("Messages", systemImage: "message")
      }
      .tag(0)
      
      // Login Credentials Tab
      NavigationStack {
        CredentialGridView(viewModel: credentialViewModel)
          .navigationTitle("Login Credentials")
          .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
              Button {
                credentialViewModel.isAddingCredential = true
              } label: {
                Image(systemName: "plus")
              }
            }
          }
          .sheet(isPresented: $credentialViewModel.isAddingCredential) {
            AddCredentialView(viewModel: credentialViewModel)
          }
          .overlay {
            if credentialViewModel.showCopiedAlert {
              CopiedAlert(message: "\(credentialViewModel.copiedItem) copied")
            }
          }
      }
      .tabItem {
        Label("Credentials", systemImage: "key")
      }
      .tag(1)
    }
    .onAppear {
      // Update view models to use the environment's modelContext
      messageViewModel.modelContext = modelContext
      credentialViewModel.modelContext = modelContext
    }
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
