import SwiftUI

struct SessionsView: View {
    
    @StateObject private var viewModel = SessionsViewModel()
    
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
            .navigationDestination(for: SessionScreen.self) { screen in
                switch screen {
                    case .add(let session):
                        AddSessionView(session: session, hasDateSelected: !session.isLock)
                    case .detail(let session):
                        SessionDetailView(session: session)
                }
            }
            .onAppear {
                hasTabBarShown = true
                viewModel.loadSession()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        StrokedText(text: "Shooting session", fontSize: 35)
            .font(.archivo(with: 35))
    }
    
    private var stumb: some View {
        VStack(spacing: 10) {
            Image(.Images.sessions)
                .resizable()
                .scaledToFit()
                .frame(width: 165, height: 160)
            
            VStack(spacing: 5) {
                Text("It’s still quiet...")
                    .font(.archivo(with: 20))
                    .foregroundStyle(.white)
             
                Text("like a target that hasn’t been shot yet")
                    .font(.archivo(with: 14))
                    .foregroundStyle(.white.opacity(0.5))
            }
            
            addButton
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background(.aljBaseGreen)
        .cornerRadius(23)
        .overlay {
            RoundedRectangle(cornerRadius: 23)
                .stroke(.white, lineWidth: 1)
        }
        .padding(.horizontal, 35)
        .padding(.top, 20)
    }
    
    private var sessions: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.sessions) { session in
                    SessionCellView(session: session) {
                        hasTabBarShown = false
                        viewModel.navigationPath.append(.detail(session))
                    }
                }
                
                addButton
            }
            .padding(.top, 5)
            .padding(.horizontal, 35)
        }
        .padding(.bottom, 110)
    }
    
    private var addButton: some View {
        Button {
            hasTabBarShown = false
            viewModel.navigationPath.append(.add(Session(isMock: false)))
        } label: {
            Text("Add session")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
                .background(.aljYellow)
                .cornerRadius(20)
        }
    }
}

#Preview {
    SessionsView(hasTabBarShown: .constant(false))
}

