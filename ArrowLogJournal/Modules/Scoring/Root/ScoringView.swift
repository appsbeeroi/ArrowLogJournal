import SwiftUI

struct ScoringView: View {
    
    @StateObject var viewModel = ScoringViewModel()
    
    @Binding var hasTabBarShown: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Image(.Images.baseBG)
                    .resizeAndAdopt()
                
                VStack {
                    navigation
                    
                    if viewModel.sessions.isEmpty {
                        stumb
                    } else {
                        sessions
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
            }
            .navigationDestination(for: ScoringScreen.self) { screen in
                switch screen {
                    case .detail(let session):
                        ScoringDetailView(session: session)
                }
            }
            .onAppear {
                hasTabBarShown = true
                viewModel.loadSession()
            }
        }
    }
    
    private var navigation: some View {
        StrokedText(text: "Scoring", fontSize: 35)
            .font(.archivo(with: 35))
    }
    
    private var stumb: some View {
        VStack(spacing: 10) {
            Image(.Images.scoring)
                .resizable()
                .scaledToFit()
                .frame(width: 165, height: 160)
            
            VStack(spacing: 5) {
                Text("No numbers yet...")
                    .font(.archivo(with: 20))
                    .foregroundStyle(.white)
             
                Text("Arrow in flight not released yet")
                    .font(.archivo(with: 14))
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .strokeView()
        .padding(.horizontal, 35)
        .padding(.top, 20)
    }
    
    private var sessions: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.sessions) { session in
                    ScoringSessionCellView(session: session) {
                        hasTabBarShown = false
                        viewModel.navigationPath.append(.detail(session))
                    }
                }
            }
            .padding(.top, 5)
            .padding(.horizontal, 35)
        }
        .padding(.bottom, 110)
    }
}

#Preview {
    ScoringView(hasTabBarShown: .constant(false))
}

