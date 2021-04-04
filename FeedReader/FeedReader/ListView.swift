import SwiftUI

import Model

struct ListView: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        VStack {
            if let rows = model.feed?.items {
                List(rows, id: \.url) { row in
                    NavigationLink(destination: DetailView(model: model, article: row)) {
                        HStack {
                            let isRead = model.readingStatuses[row.url] ?? false
                            Image(systemName: isRead ? "checkmark.circle" : "circle")
                            Text(row.title)
                        }
                    }
                }
            } else {
                List([0], id: \.self) { _ in Text("Loading") }
            }
            Button(action: model.reload) { Text("Reload feed") }.padding()
        }
        .navigationTitle(Text("Articles"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
import MockService

struct ListView_Previews: PreviewProvider {
    
   static var previews: some View {
      let model = Model(services: Services.mock)
      return ListView(model: model)
   }
}
#endif
