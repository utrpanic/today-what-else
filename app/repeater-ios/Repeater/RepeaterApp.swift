import SwiftUI
import SwiftData
import RepeaterModel

@main
struct RepeaterApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: [SavedMessage.self, Credential.self])
    }
  }
}
