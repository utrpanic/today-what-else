import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        NavigationView {
            List(model.feed?.items ?? [], id: \.url) { row in
                NavigationLink(destination: DetailView(row)) {
                    Text(row.title)
                }
            }
            .navigationTitle(Text("Articles"))
            .navigationBarTitleDisplayModeInline()
            
            Color.clear
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
    func DetailView(_ row: Article) -> some View {
        return SharedWebView(content: row.content)
            .navigationTitle(Text(row.title))
            .navigationBarTitleDisplayModeInline()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(model: Model())
    }
}
