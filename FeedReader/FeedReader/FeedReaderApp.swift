import SwiftUI

import Model

@main
struct FeedReaderApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: Model(services: Services()))
        }
    }
}
