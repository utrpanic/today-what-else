//
//  EditMessageView.swift
//  Views
//
//  Created by Claude Code on 4/27/25.
//

import SwiftUI
import RepeaterViewModel

public struct EditMessageView: View {
  @ObservedObject var viewModel: MessageViewModel
  @Environment(\.dismiss) private var dismiss
  
  public init(viewModel: MessageViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("Edit Slack Message")
          .font(.caption)
          .foregroundColor(.secondary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        TextField("Message content", text: $viewModel.newMessage, axis: .vertical)
          .textFieldStyle(.roundedBorder)
          .lineLimit(5...)
          .padding(.horizontal)
        
        Button("Save Changes") {
          viewModel.saveMessage()
          dismiss()
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .disabled(viewModel.newMessage.isEmpty)
      }
      .navigationTitle("Edit Message")
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