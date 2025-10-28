import SwiftUI

struct AppTabView: View {
    
    @State private var selection: AppTabViewState = .sessions
    
    @State private var hasTabBarShown = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            tabView
            tabBar
        }
    }
    
    private var tabView: some View {
        TabView(selection: $selection) {
            SessionsView(hasTabBarShown: $hasTabBarShown)
                .tag(AppTabViewState.sessions)
            
            ScoringView(hasTabBarShown: $hasTabBarShown)
                .tag(AppTabViewState.scoring)
            
            HistoryView(hasTabBarShown: $hasTabBarShown)
                .tag(AppTabViewState.history)
            
            SettingsView(hasTabBarShown: $hasTabBarShown)
                .tag(AppTabViewState.settings)
        }
    }
    
    private var tabBar: some View {
        VStack {
            HStack {
                ForEach(AppTabViewState.allCases) { state in
                    Button {
                        selection = state
                    } label: {
                        Image(state.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(state == selection ? .aljYellow : .aljLightGreen)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 76)
            .padding(.horizontal, 25)
            .background(.aljGreen)
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 1)
            }
            .padding(.horizontal, 35)
            .padding(.bottom, 20)
            .opacity(hasTabBarShown ? 1 : 0)
            .animation(.smooth, value: hasTabBarShown)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    AppTabView()
}








