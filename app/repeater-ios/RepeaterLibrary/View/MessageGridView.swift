import SwiftUI
import RepeaterModel
import RepeaterViewModel
import SwiftData

public struct MessageGridView: View {
  @ObservedObject var viewModel: MessageViewModel
  @Query private var messages: [SavedMessage]
  
  let columns = [
    GridItem(.adaptive(minimum: 150), spacing: 16)
  ]
  
  public init(viewModel: MessageViewModel, sortOrder: [SortDescriptor<SavedMessage>] = [SortDescriptor(\.createdAt, order: .reverse)]) {
    self.viewModel = viewModel
    self._messages = Query(sort: sortOrder)
  }
  
  public var body: some View {
    ScrollView {
      if messages.isEmpty {
        ContentUnavailableView(
          "No Saved Messages",
          systemImage: "clipboard",
          description: Text("Tap the add button to save a message")
        )
        .padding()
      } else {
        LazyVGrid(columns: columns, spacing: 16) {
          ForEach(messages) { message in
            MessageCell(message: message, onTap: {
              viewModel.copyToClipboard(message.content)
            })
            .contextMenu {
              Button(role: .destructive) {
                viewModel.deleteMessage(message)
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
          }
        }
        .padding()
      }
    }
  }
}

public struct MessageCell: View {
  let message: SavedMessage
  let onTap: () -> Void
  
  public init(message: SavedMessage, onTap: @escaping () -> Void) {
    self.message = message
    self.onTap = onTap
  }
  
  public var body: some View {
    Button(action: onTap) {
      Text(message.content)
        .lineLimit(3)
        .multilineTextAlignment(.leading)
        .padding()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
    .buttonStyle(.plain)
  }
}
