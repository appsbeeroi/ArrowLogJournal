import Combine
import Foundation

final class HistoryViewModel: ObservableObject {
    
    private let userDefaultManager = UDManager.shared
    
    @Published var navigationPath: [HistoryScreen] = []
    
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var highestAccuracySession: Session?
    @Published private(set) var longestSeriesSession: Session?
    @Published private(set) var worstResultSession: Session?
    
    @Published private(set) var weeklyAccuracy: Int = 0
    @Published private(set) var monthlyAccuracy: Int = 0
    
    func loadSession() {
        Task { [weak self] in
            guard let self else { return }
            
            let sessions = await self.userDefaultManager.get([Session].self, for: .sessions) ?? []
            
            await MainActor.run {
                self.sessions = sessions
                self.calculateAccuracy()
                self.findRecords()
            }
        }
    }
    
    private func calculateAccuracy() {
        let now = Date()
        let calendar = Calendar.current
        
        let weeklySessions = sessions.filter {
            guard let days = calendar.dateComponents([.day], from: $0.date, to: now).day else { return false }
            return days <= 7
        }
        
        let monthlySessions = sessions.filter {
            guard let days = calendar.dateComponents([.day], from: $0.date, to: now).day else { return false }
            return days <= 30
        }
        
        weeklyAccuracy = Self.averageAccuracy(for: weeklySessions)
        monthlyAccuracy = Self.averageAccuracy(for: monthlySessions)
    }
    
    private static func averageAccuracy(for sessions: [Session]) -> Int {
        let accuracies: [Double] = sessions.compactMap { session in
            guard let shots = Double(session.shots),
                  let hits = Double(session.hits),
                  shots > 0 else { return nil }
            return min(100, (hits / shots) * 100)
        }
        
        guard !accuracies.isEmpty else { return 0 }
        let avg = accuracies.reduce(0, +) / Double(accuracies.count)
        return Int(avg.rounded())
    }
    
    private func findRecords() {
        guard !sessions.isEmpty else { return }
        
        highestAccuracySession = sessions.max(by: { lhs, rhs in
            lhs.accuracy < rhs.accuracy
        })
        
        longestSeriesSession = sessions.max(by: { lhs, rhs in
            (Int(lhs.series) ?? 0) < (Int(rhs.series) ?? 0)
        })
        
        worstResultSession = sessions.min(by: { lhs, rhs in
            lhs.accuracy < rhs.accuracy
        })
    }
}
