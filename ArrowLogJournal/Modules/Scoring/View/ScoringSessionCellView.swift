import SwiftUI

struct ScoringSessionCellView: View {
    
    let session: Session
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            GeometryReader { geo in
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Image(.Images.sessions)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 68, height: 65)
                        
                        VStack(spacing: 8) {
                            date
                            result
                        }
                    }
                    
                    VStack(spacing: 4) {
                        accuracy
                        accuracyProgress(with: geo)
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .strokeView()
            }
            .frame(height: 150)
        }
    }
    
    private var date: some View {
        HStack {
            Image(.Icons.calendar)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            Text(session.date.formatted(.dateTime.year().month(.twoDigits).day()))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 13))
                .foregroundStyle(.white)
        }
    }
    
    private var result: some View {
        VStack(spacing: 0) {
            Text("Result")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 13))
                .foregroundStyle(.aljLightGreen)
            
            if let shots = Int(session.shots),
               let hits = Int(session.hits) {
                Text("\(hits)/\(shots)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.archivo(with: 20))
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var accuracy: some View {
        HStack {
            Text("Accuracy")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            if let shots = Double(session.shots),
               let hits = Double(session.hits) {
                let accuracy = min(100, Int((hits / shots) * 100))
                
                Text("\(accuracy)%")
                    .font(.archivo(with: 14))
                    .foregroundStyle(.white)
            } else {
                Text("")
            }
        }
    }
    
    private func accuracyProgress(with geo: GeometryProxy) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(height: 17)
            .frame(maxWidth: .infinity)
        
            .foregroundStyle(.aljGreen)
            .overlay {
                if let shots = Double(session.shots),
                   let hits = Double(session.hits) {
                    let accuracy = min(1, (hits / shots))
                    let maxSize = geo.size.width - 24
                    
                    HStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: min(maxSize,  CGFloat(geo.size.width * accuracy)))
                            .foregroundStyle(.aljYellow)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
    }
}
