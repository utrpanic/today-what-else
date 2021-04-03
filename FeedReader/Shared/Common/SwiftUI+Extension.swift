import SwiftUI

extension View {
    
    func navigationBarTitleDisplayModeInline() -> some View {
        #if os(iOS)
        return self.navigationBarTitleDisplayMode(.inline)
        #else
        return self
        #endif
    }   
}
