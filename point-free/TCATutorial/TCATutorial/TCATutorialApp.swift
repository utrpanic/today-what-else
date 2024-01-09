import ComposableArchitecture
import SwiftUI

@main
struct TCATutorialApp: App {
  
  static var store = Store(initialState: CounterFeature.State()) {
    CounterFeature()._printChanges()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView(store: TCATutorialApp.store)
    }
  }
}
