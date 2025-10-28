import SwiftUI

struct HistoryView: View {
    
    @StateObject private var viewModel = HistoryViewModel()
    
    @Binding var hasTabBarShown: Bool
    
    @State private var isShowAllSessions = false
    @State private var isShowAllRecords = false
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Image(.Images.baseBG)
                    .resizeAndAdopt()
                
                VStack {
                    navigation
                    
                    if viewModel.sessions.isEmpty {
                        emptyHistory
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 24) {
                                accuracy
                                pastSessions
                                records
                            }
                            .padding(.top, 5)
                            .padding(.horizontal, 35)
                        }
                        .padding(.bottom, 100)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
            }
            .navigationDestination(for: HistoryScreen.self) { screen in
                switch screen {
                    case .record(let session, let type):
                        RecordDetailView(recordType: type, session: session)
                    case .session(let session):
                        SessionDetailView(session: session)
                }
            }
            .animation(.smooth, value: viewModel.sessions)
            .animation(.easeInOut, value: isShowAllRecords)
            .animation(.easeInOut, value: isShowAllSessions)
            .onAppear {
                hasTabBarShown = true
                viewModel.loadSession()
            }
        }
    }
    
    private var navigation: some View {
        StrokedText(text: "History", fontSize: 35)
            .font(.archivo(with: 35))
    }
    
    private var emptyHistory: some View {
        VStack(spacing: 10) {
            Image(.Images.history)
                .resizable()
                .scaledToFit()
                .frame(width: 164, height: 110)
            
            Text("While it’s empty...")
                .frame(maxWidth: .infinity)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
            
            Text("like a target that hasn’t been shot yet")
                .font(.archivo(with: 14))
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 16)
        .strokeView()
        .padding(.horizontal, 35)
    }
    
    private var accuracy: some View {
        VStack(spacing: 16) {
            Text("Accuracy")
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
            
            HStack {
                VStack {
                    Text("Weekly")
                        .frame(maxWidth: .infinity)
                        .font(.archivo(with: 14))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Text("\(viewModel.weeklyAccuracy.formatted())%")
                        .font(.archivo(with: 36))
                        .foregroundStyle(.white)
                }
                
                VStack {
                    Text("Monthly")
                        .frame(maxWidth: .infinity)
                        .font(.archivo(with: 14))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Text("\(viewModel.monthlyAccuracy.formatted())%")
                        .font(.archivo(with: 36))
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.vertical, 25)
        .strokeView()
    }
    
    private var pastSessions: some View {
        LazyVStack(spacing: 8) {
            HStack {
                Text("Past Sessions")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.archivo(with: 20))
                    .foregroundStyle(.white)
                
                Button {
                    isShowAllSessions.toggle()
                } label: {
                    Text(isShowAllSessions ? "Hide" : "See all")
                        .font(.archivo(with: 20))
                        .foregroundStyle(.aljYellow)
                }
            }
            
            let source = Array(viewModel.sessions.prefix(isShowAllSessions ? 100 : 3))
            
            ForEach(source) { session in
                SessionCellView(session: session) {
                    hasTabBarShown = false
                    viewModel.navigationPath.append(.session(session))
                }
            }
        }
    }
    
    private var records: some View {
        LazyVStack(spacing: 8) {
            Text("Personal records")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
            
            LazyVStack(spacing: 8) {
                ForEach(RecordType.allCases) { type in
                    if let session = recordSession(for: type) {
                        RecordSessionCellView(session: session, recordType: type) {
                            hasTabBarShown = false
                            viewModel.navigationPath.append(.record(session, type: type))
                        }
                    }
                }
            }
        }
    }
    
    private func recordSession(for type: RecordType) -> Session? {
        switch type {
            case .highestAccuracy:
                return viewModel.highestAccuracySession
            case .LongestSeriesWithoutMiss:
                return viewModel.longestSeriesSession
            case .worstResult:
                return viewModel.worstResultSession
        }
    }
}

#Preview {
    HistoryView(hasTabBarShown: .constant(false))
}

