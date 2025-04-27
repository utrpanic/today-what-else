import SwiftUI
import RepeaterModel
import RepeaterViewModel
import SwiftData

public struct MessageGridView: View {
  @ObservedObject var viewModel: MessageViewModel
  @Query private var messages: [SavedMessage]
  
  let columns = [
    GridItem(.adaptive(minimum: 280), spacing: 16)
  ]
  
  public init(viewModel: MessageViewModel, sortOrder: [SortDescriptor<SavedMessage>] = [SortDescriptor(\.sortOrder)]) {
    self.viewModel = viewModel
    self._messages = Query(sort: sortOrder)
  }
  
  public var body: some View {
    VStack {
      if messages.isEmpty {
        ContentUnavailableView(
          "No Saved Messages",
          systemImage: "clipboard",
          description: Text("Tap the add button to save a message")
        )
        .padding()
      } else {
        if viewModel.isEditMode {
          // List view for reordering in edit mode
          List {
            ForEach(messages) { message in
              HStack {
                Image(systemName: "line.3.horizontal")
                  .foregroundColor(.gray)
                
                Text(message.content)
                  .lineLimit(1)
              }
              .padding(.vertical, 8)
            }
            .onMove { source, destination in
              viewModel.moveMessages(from: source, to: destination, messages: messages)
            }
            .onDelete { indexSet in
              for index in indexSet {
                viewModel.deleteMessage(messages[index])
              }
            }
          }
          .listStyle(.plain)
        } else {
          // Grid view for normal mode
          ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
              ForEach(messages) { message in
                MessageCell(message: message, onTap: {
                  viewModel.copyToClipboard(message.content)
                })
                .contextMenu {
                  Button {
                    viewModel.startEditing(message)
                  } label: {
                    Label("Edit", systemImage: "pencil")
                  }
                  
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
    // Removed toolbar edit button
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
