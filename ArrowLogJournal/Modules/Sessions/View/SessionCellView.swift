import SwiftUI

struct SessionCellView: View {
    
    let session: Session
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                Image(.Images.sessions)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 78, height: 75)
                
                VStack(spacing: 6) {
                    HStack {
                        Image(.Icons.calendar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21, height: 21)
                        
                        Text(session.date.formatted(.dateTime.year().month(.twoDigits).day()))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.archivo(with: 13))
                            .foregroundStyle(.white)
                    }
                    
                    HStack(spacing: 16) {
                        VStack(spacing: 0) {
                            Text("Series")
                                .font(.archivo(with: 14))
                                .foregroundStyle(.aljLightGreen)
                            
                            Text(session.series)
                                .font(.archivo(with: 20))
                                .foregroundStyle(.white)
                        }
                        
                        VStack(spacing: 0) {
                            Text("Shots")
                                .font(.archivo(with: 14))
                                .foregroundStyle(.aljLightGreen)
                            
                            Text(session.shots)
                                .font(.archivo(with: 20))
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .background(.aljBaseGreen)
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white, lineWidth: 1)
            }
        }
    }
}
