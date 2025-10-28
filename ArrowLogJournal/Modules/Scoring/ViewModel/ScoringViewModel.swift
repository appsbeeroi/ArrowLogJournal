import Combine
import Foundation

final class ScoringViewModel: ObservableObject {
    
    private let userDefaultManager = UDManager.shared
    
    @Published var navigationPath: [ScoringScreen] = []
    
    @Published private(set) var sessions: [Session] = []
    
    func loadSession() {
        Task { [weak self] in
            guard let self else { return }
            
            let sessions = await self.userDefaultManager.get([Session].self, for: .sessions) ?? []
            
            await MainActor.run {
                self.sessions = sessions
            }
        }
    }
}
