import SwiftUI
import WebKit

struct SharedWebView: NSViewRepresentable {
    
    let content: String
    
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(self.content, baseURL: nil)
    }
}
