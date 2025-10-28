enum HistoryScreen: Hashable {
    case session(Session)
    case record(Session, type: RecordType)
}
