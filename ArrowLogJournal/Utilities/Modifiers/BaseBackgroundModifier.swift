import SwiftUI

struct BaseBackgroundModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(.aljBaseGreen)
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 1)
            }
    }
}

extension View {
    func strokeView() -> some View {
        modifier(BaseBackgroundModifier())
    }
}
