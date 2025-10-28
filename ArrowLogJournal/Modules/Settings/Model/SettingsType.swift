enum SettingsType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case about
    case notification
    case history
    
    var message: String {
        switch self {
            case .about:
                "About the app"
            case .notification:
                "Notification"
            case .history:
                "History"
        }
    }
}
