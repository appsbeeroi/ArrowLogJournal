enum RecordType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case highestAccuracy
    case LongestSeriesWithoutMiss
    case worstResult
    
    var title: String {
        switch self {
            case .highestAccuracy:
                "Highest Accuracy"
            case .LongestSeriesWithoutMiss:
                "Longest Series Without Miss"
            case .worstResult:
                "Worst Result"
        }
    }
}
