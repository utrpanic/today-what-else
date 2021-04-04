import SwiftUI

import Model

struct ContentView: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        NavigationView {
            List(model.feed?.items ?? [], id: \.url) { row in
                NavigationLink(destination: DetailView(model: model, article: row)) {
                    HStack {
                        let isRead = model.readingStatuses[row.url] ?? false
                        Image(systemName: isRead ? "checkmark.circle" : "circle")
                        Text(row.title)
                    }
                }
            }
            .navigationTitle(Text("Articles"))
            .navigationBarTitleDisplayMode(.inline)
            
            Color.clear
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
