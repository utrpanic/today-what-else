import SwiftUI
import RepeaterViewModel

public struct AddMessageView: View {
  @ObservedObject var viewModel: MessageViewModel
  @Environment(\.dismiss) private var dismiss
  
  public init(viewModel: MessageViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("Paste content from Slack")
          .font(.caption)
          .foregroundColor(.secondary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        TextField("Message content", text: $viewModel.newMessage, axis: .vertical)
          .textFieldStyle(.roundedBorder)
          .lineLimit(5...)
          .padding(.horizontal)
        
        Button("Save Message") {
          if !viewModel.newMessage.isEmpty {
            viewModel.saveMessage()
            dismiss()
          }
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .disabled(viewModel.newMessage.isEmpty)
      }
      .navigationTitle("Add New Message")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Cancel") {
            dismiss()
            viewModel.newMessage = ""
          }
        }
      }
    }
    .presentationDetents([.medium])
  }
}
