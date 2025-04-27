import SwiftUI
import RepeaterModel
import RepeaterView
import RepeaterViewModel
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @StateObject private var viewModel: MessageViewModel
  
  init() {
    // We'll update this in onAppear to use the environment's modelContext
    self._viewModel = StateObject(wrappedValue: MessageViewModel(modelContext: ModelContext(try! ModelContainer(for: SavedMessage.self))))
  }
  
  var body: some View {
    NavigationStack {
      MessageGridView(viewModel: viewModel)
        .navigationTitle("Slack Repeater")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              viewModel.isAddingMessage = true
            } label: {
              Image(systemName: "plus")
            }
          }
        }
        .sheet(isPresented: $viewModel.isAddingMessage) {
          AddMessageView(viewModel: viewModel)
        }
        .overlay {
          if viewModel.showCopiedAlert {
            VStack {
              Spacer()
              Text("Copied to clipboard")
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .padding(.bottom)
            }
          }
        }
    }
    .onAppear {
      // Update the viewModel to use the environment's modelContext
      viewModel.modelContext = modelContext
    }
  }
}
