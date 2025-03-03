import ComposableArchitecture
import SwiftUI

@main
struct PrimeTime2App: App {
  var body: some Scene {
    WindowGroup {
      ContentView(
        store: Store(
          initialValue: AppState(),
          reducer: with(
            appReducer,
            compose(
              logging,
              activityFeed
            )
          )
        )
      )
    }
  }
}
