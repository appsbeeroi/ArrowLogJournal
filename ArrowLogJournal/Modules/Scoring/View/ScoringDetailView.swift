import SwiftUI

struct ScoringDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let session: Session
    
    var body: some View {
        ZStack {
            Image(.Images.baseBG)
                .resizeAndAdopt()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        VStack(spacing: 10) {
                            image
                            date
                            result
                            
                            HStack {
                                target
                                
                                Spacer()
                                
                                near
                            }
                            
                            HStack {
                                miss
                                
                                Spacer()
                                
                                distance
                            }
                        }
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 16)
                    .strokeView()
                    .padding(.top, 5)
                    .padding(.horizontal, 35)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(.Icons.back)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Image(.Images.sessions)
            .resizable()
            .scaledToFit()
            .frame(width: 180, height: 175)
    }
    
    private var date: some View {
        HStack {
            Image(.Icons.calendar)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(session.date.formatted(.dateTime.year().month(.twoDigits).day()))
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var result: some View {
        VStack(spacing: 8){
            Text("Accuracy")
                .font(.archivo(with: 14))
                .foregroundStyle(.white.opacity(0.5))
            
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
    
    private var target: some View {
        HStack {
            Text("In Target")
                .font(.archivo(with: 14))
                .foregroundStyle(.white.opacity(0.5))
            Text(session.hits)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var near: some View {
        HStack {
            Text("Near")
                .font(.archivo(with: 14))
                .foregroundStyle(.white.opacity(0.5))
            Text(session.near)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var miss: some View {
        HStack {
            Text("Miss")
                .font(.archivo(with: 14))
                .foregroundStyle(.white.opacity(0.5))
            Text(session.miss)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var distance: some View {
        HStack {
            Text("Distance")
                .font(.archivo(with: 14))
                .foregroundStyle(.white.opacity(0.5))
            
            Text(session.distance + " m")
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ScoringDetailView(session: Session(isMock: true))
}

