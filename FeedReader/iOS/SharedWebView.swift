import SwiftUI
import WebKit

struct SharedWebView: UIViewRepresentable {
    
    let content: String

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
        
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(self.content, baseURL: nil)
    }
}
