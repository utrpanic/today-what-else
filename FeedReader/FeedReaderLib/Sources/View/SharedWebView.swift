import SwiftUI
import WebKit

public struct SharedWebView: UIViewRepresentable {
    
    let content: String
    
    public init(content: String) {
        self.content = content
    }

    public func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
        
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(self.content, baseURL: nil)
    }
}
