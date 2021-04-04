import SwiftUI

import Model

struct ContentView: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        return NavigationView {
            ListView(model: model)
            Color.clear
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .alert(item: $model.error) { error in
            Alert(title: Text(verbatim: error.localizedDescription))
        }
    }
}
