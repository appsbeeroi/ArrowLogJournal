import SwiftUI

struct SplashScreen: View {
    
    @Binding var isLaunched: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.baseBG)
                .resizeAndAdopt()
            
            VStack {
                StrokedText(text: "ArrowLog\nJournal", fontSize: 60)
                    .multilineTextAlignment(.center)
                
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
            withAnimation {
                isLaunched = true
            }
        }
    }
}

#Preview {
    SplashScreen(isLaunched: .constant(false))
}
