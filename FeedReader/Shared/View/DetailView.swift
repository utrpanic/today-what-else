import SwiftUI

struct DetailView: View {
    
    @ObservedObject var model: Model
    
    let article: Article
    
    var body: some View {
        let reading = model.readingStatuses[article.url] ?? false
        return SharedWebView(content: article.content)
            .navigationTitle(Text(article.title))
            .toolbar {
                Button {
                    model.setReading(!reading, url: article.url)
                } label: {
                    Text(reading ? "Mark as unread" : "Mark as read")
                }
            }
            .navigationBarTitleDisplayModeInline()
            .onAppear { model.setReading(true, url: article.url) }
    }
}
