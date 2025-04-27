import SwiftUI
import RepeaterViewModel

public struct AddCredentialView: View {
  @ObservedObject var viewModel: CredentialViewModel
  @Environment(\.dismiss) private var dismiss
  
  public init(viewModel: CredentialViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    NavigationStack {
      Form {
        Section("Credential Information") {
          TextField("Label (optional)", text: $viewModel.newLabel)
          
          TextField("Email", text: $viewModel.newEmail)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
          
          SecureField("Password", text: $viewModel.newPassword)
            .textContentType(.password)
        }
        
        Section {
          Button("Save Credential") {
            viewModel.saveCredential()
            dismiss()
          }
          .frame(maxWidth: .infinity)
          .disabled(viewModel.newEmail.isEmpty || viewModel.newPassword.isEmpty)
        }
      }
      .navigationTitle("Add Credential")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Cancel") {
            dismiss()
            viewModel.newEmail = ""
            viewModel.newPassword = ""
            viewModel.newLabel = ""
          }
        }
      }
    }
    .presentationDetents([.medium])
  }
}