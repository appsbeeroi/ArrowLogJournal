import UserNotifications

enum NotificationPermissionStatus {
    case authorized
    case denied
    case notDetermined
}

final class NotificationPermissionManager {
    
    static let shared = NotificationPermissionManager()
    private init() {}
    
    
    var currentStatus: NotificationPermissionStatus {
        get async {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()
            
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                return .authorized
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            @unknown default:
                return .denied
            }
        }
    }
    
    @discardableResult
    func requestAuthorization() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            if granted {
                await center.setNotificationCategories([])
            }
            return granted
        } catch {
            print("❌ Notification authorization failed: \(error.localizedDescription)")
            return false
        }
    }
}
