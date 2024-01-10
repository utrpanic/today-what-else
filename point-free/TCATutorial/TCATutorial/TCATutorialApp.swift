import ComposableArchitecture
import SwiftUI

@main
struct TCATutorialApp: App {
  static var store = Store(initialState: AppFeature.State()) {
    AppFeature()
  }

  var body: some Scene {
    WindowGroup {
      AppView(store: TCATutorialApp.store)
    }
  }
}
