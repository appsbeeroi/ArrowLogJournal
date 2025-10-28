import Foundation

struct Session: Identifiable, Codable, Hashable {
    var id: UUID
    var date: Date
    var series: String
    var shots: String
    var hits: String
    var near: String
    var miss: String
    var distance: String
    var notes: String
    
    var isLock: Bool {
        series == "" || shots == "" || hits == "" || near == "" || miss == "" || distance == "" || notes == ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.date = Date()
        self.series = isMock ? "1" : ""
        self.shots = isMock ? "10" : ""
        self.hits = isMock ? "8" : ""
        self.near = isMock ? "10" : ""
        self.miss = isMock ? "2" : ""
        self.distance = isMock ? "100" : ""
        self.notes = isMock ? "Test note" : ""
    }
}

extension Session {
    var accuracy: Double {
        guard let shots = Double(shots),
              let hits = Double(hits),
              shots > 0 else { return 0 }
        return (hits / shots) * 100
    }
}
