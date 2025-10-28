import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isSavedNotification") var isSavedNotification = false
    
    @Binding var hasTabBarShown: Bool
    
    @State private var isShowAlert = false
    @State private var isToggleSwitchedOn = false
    @State private var isShowWeb = false
    @State private var isShowClear = false
    
    var body: some View {
        ZStack {
            Image(.Images.baseBG)
                .resizeAndAdopt()
            
            VStack {
                navigation
                
                ForEach(SettingsType.allCases) { type in
                    Button {
                        switch type {
                            case .about:
                                hasTabBarShown = false
                                isShowWeb.toggle()
                            case .notification:
                                return
                            case .history:
                                UDManager.shared.remove(.sessions)
                                isShowClear.toggle()
                        }
                    } label: {
                        HStack {
                            Text(type.message)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.archivo(with: 20))
                                .foregroundStyle(.white)
                            
                            switch type {
                                case .about:
                                    Image(systemName: "chevron.forward")
                                        .tint(.aljYellow)
                                case .notification:
                                    Toggle("", isOn: $isToggleSwitchedOn)
                                        .labelsHidden()
                                        .tint(.aljYellow)
                                case .history:
                                    Text("Clear")
                                        .font(.archivo(with: 20))
                                        .foregroundStyle(.red)
                                        .opacity(isShowClear ? 1 : 0)
                                        .animation(.default, value: isShowClear)
                            }
                        }
                        .frame(height: 60)
                        .padding(.horizontal, 10)
                        .strokeView()
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 35)
            
            if isShowWeb,
               let url = URL(string: "https://www.apple.com") {
                WebView(url: url) {
                    hasTabBarShown = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .alert("Notification permission wasn't allowed", isPresented: $isShowAlert) {
            Button("Yes") {
                openSettings()
            }
            
            Button("No") {
                isToggleSwitchedOn = false
            }
        } message: {
            Text("Open app settings?")
        }
        .onChange(of: isShowClear) { isShow in
            if !isShowClear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShowClear = false
                }
            }
        }
        .onChange(of: isToggleSwitchedOn) { isToggleSwitchedOn in
            if isToggleSwitchedOn {
                Task {
                    switch await NotificationPermissionManager.shared.currentStatus {
                        case .authorized:
                            self.isToggleSwitchedOn = true
                        case .denied:
                            isShowAlert = true
                        case .notDetermined:
                            await NotificationPermissionManager.shared.requestAuthorization()
                    }
                }
            } else {
                self.isToggleSwitchedOn = false
            }
        }
    }
    
    private var navigation: some View {
        StrokedText(text: "Settings", fontSize: 35)
            .font(.archivo(with: 35))
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

#Preview {
    SettingsView(hasTabBarShown: .constant(false))
}
