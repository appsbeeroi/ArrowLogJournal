import Foundation

enum AppTabViewState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case sessions
    case scoring
    case history
    case settings
    
    var icon: ImageResource {
        switch self {
            case .sessions:
                    .Images.TabView.sessions
            case .scoring:
                    .Images.TabView.scoring
            case .history:
                    .Images.TabView.history
            case .settings:
                    .Images.TabView.settings
        }
    }
}
