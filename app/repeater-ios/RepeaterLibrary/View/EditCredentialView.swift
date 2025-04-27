//
//  EditCredentialView.swift
//  Views
//
//  Created by Claude Code on 4/27/25.
//

import SwiftUI
import RepeaterViewModel

public struct EditCredentialView: View {
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
          Button("Save Changes") {
            viewModel.saveCredential()
            dismiss()
          }
          .frame(maxWidth: .infinity)
          .disabled(viewModel.newEmail.isEmpty || viewModel.newPassword.isEmpty)
        }
      }
      .navigationTitle("Edit Credential")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Cancel") {
            viewModel.cancelEditing()
            dismiss()
          }
        }
      }
    }
    .presentationDetents([.medium])
  }
}