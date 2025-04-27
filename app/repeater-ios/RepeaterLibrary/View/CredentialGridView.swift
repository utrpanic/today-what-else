import SwiftUI
import RepeaterModel
import RepeaterViewModel
import SwiftData

public struct CredentialGridView: View {
  @ObservedObject var viewModel: CredentialViewModel
  @Query private var credentials: [Credential]
  
  let columns = [
    GridItem(.adaptive(minimum: 280), spacing: 16)
  ]
  
  public init(viewModel: CredentialViewModel, sortOrder: [SortDescriptor<Credential>] = [SortDescriptor(\.sortOrder)]) {
    self.viewModel = viewModel
    self._credentials = Query(sort: sortOrder)
  }
  
  public var body: some View {
    VStack {
      if credentials.isEmpty {
        ContentUnavailableView(
          "No Saved Credentials",
          systemImage: "key",
          description: Text("Tap the add button to save login credentials")
        )
        .padding()
      } else {
        if viewModel.isEditMode {
          // List view for reordering in edit mode
          List {
            ForEach(credentials) { credential in
              HStack {
                Image(systemName: "line.3.horizontal")
                  .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                  Text(credential.label ?? "Login Credential")
                    .fontWeight(.medium)
                  Text(credential.email)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
              }
              .padding(.vertical, 8)
            }
            .onMove { source, destination in
              viewModel.moveCredentials(from: source, to: destination, credentials: credentials)
            }
            .onDelete { indexSet in
              for index in indexSet {
                viewModel.deleteCredential(credentials[index])
              }
            }
          }
          .listStyle(.plain)
        } else {
          // Grid view for normal mode
          ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
              ForEach(credentials) { credential in
                CredentialCell(credential: credential, viewModel: viewModel)
                  .contextMenu {
                    Button {
                      viewModel.startEditing(credential)
                    } label: {
                      Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                      viewModel.deleteCredential(credential)
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

public struct CredentialCell: View {
  let credential: Credential
  let viewModel: CredentialViewModel
  
  public init(credential: Credential, viewModel: CredentialViewModel) {
    self.credential = credential
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack(spacing: 12) {
      // Title/Label area
      VStack(alignment: .leading) {
        Text(credential.label ?? "Login Credential")
          .font(.headline)
          .lineLimit(1)
        
        Text(credential.email)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(1)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal)
      
      Divider()
      
      // Buttons
      HStack {
        Button {
          viewModel.copyToClipboard(credential.email, itemName: "Email")
        } label: {
          VStack {
            Image(systemName: "envelope")
            Text("Email")
              .font(.caption)
          }
          .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.mini)
        
        Button {
          viewModel.copyToClipboard(credential.password, itemName: "Password")
        } label: {
          VStack {
            Image(systemName: "key")
            Text("Password")
              .font(.caption)
          }
          .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.mini)
      }
      .padding(.horizontal)
      .padding(.bottom, 8)
    }
    .frame(height: 130)
    .background(Color.blue.opacity(0.1))
    .cornerRadius(12)
  }
}