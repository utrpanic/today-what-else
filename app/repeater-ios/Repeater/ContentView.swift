import SwiftUI
import RepeaterModel
import RepeaterView
import RepeaterViewModel

struct ContentView: View {
  @StateObject private var viewModel = MessageViewModel()
  
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
  }
}
