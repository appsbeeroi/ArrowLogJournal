import Foundation
import Combine

final class SessionsViewModel: ObservableObject {
    
    private let userDefaultManager = UDManager.shared
    
    @Published var navigationPath: [SessionScreen] = []
    
    @Published private(set) var sessions: [Session] = []
    
    func loadSession() {
        Task { [weak self] in
            guard let self else { return }
            
            let sessions = await userDefaultManager.get([Session].self, for: .sessions) ?? []
            
            await MainActor.run {
                self.sessions = sessions
            }
        }
    }
    
    func save(_ session: Session) {
        Task { [weak self] in
            guard let self else { return }
            
            var sessions = await userDefaultManager.get([Session].self, for: .sessions) ?? []
            
            if let index = sessions.firstIndex(where: { $0.id == session.id }) {
                sessions[index] = session
            } else {
                sessions.append(session)
            }
            
            await self.userDefaultManager.set(sessions, for: .sessions)
            
            await MainActor.run {
                self.navigationPath.removeAll()
            }
        }
    }
    
    func remove(_ session: Session) {
        Task { [weak self] in
            guard let self else { return }
            
            var sessions = await self.userDefaultManager.get([Session].self, for: .sessions) ?? []
            
            if let index = sessions.firstIndex(where: { $0.id == session.id }) {
                sessions.remove(at: index)
            }
            
            await self.userDefaultManager.set(sessions, for: .sessions)
            
            await MainActor.run {
                self.navigationPath.removeAll()
            }
        }
    }
}
