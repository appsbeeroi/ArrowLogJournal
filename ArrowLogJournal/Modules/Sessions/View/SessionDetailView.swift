import SwiftUI

struct SessionDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: SessionsViewModel
    
    let session: Session
    
    @State private var isShowDeleteAlert = false
    
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
                        }
                        
                        VStack(spacing: 20) {
                            HStack {
                                series
                                shots
                            }
                            
                            HStack {
                                hits
                                near
                            }
                            
                            HStack {
                                miss
                                distance
                            }
                        }
                        
                        notes
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 20)
                    .strokeView()
                    .padding(.top, 5)
                    .padding(.horizontal, 35)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden()
        .alert("Are you sure you want to delete this session?", isPresented: $isShowDeleteAlert) {
            Button("Yes", role: .destructive) {
                viewModel.remove(session)
            }
        }
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
            
            HStack(spacing: 20) {
                Button {
                    viewModel.navigationPath.append(.add(session))
                } label: {
                    StrokedText(
                        text: "Edit",
                        fontSize: 25,
                        foregroundColor: .aljBlue,
                        backgroundColor: .white
                    )
                }
                
                Button {
                    isShowDeleteAlert.toggle()
                } label: {
                    StrokedText(
                        text: "Delete",
                        fontSize: 25,
                        foregroundColor: .aljRed,
                        backgroundColor: .white
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Image(.Images.sessions)
            .resizable()
            .scaledToFit()
            .frame(width: 182, height: 175)
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
    }
    
    private var series: some View {
        HStack(spacing: 8) {
            Text("Series")
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.series)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var shots: some View {
        HStack(spacing: 8) {
            Text("Shots")
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.shots)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var hits: some View {
        HStack(spacing: 8) {
            Text("Hits")
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.hits)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var near: some View {
        HStack(spacing: 8) {
            Text("Near")
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.near)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var miss: some View {
        HStack(spacing: 8) {
            Text("Miss")
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.miss)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var distance: some View {
        HStack(spacing: 8) {
            Text("Distance")
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.distance)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
        }
    }
    
    private var notes: some View {
        VStack(spacing: 8) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 14))
                .foregroundStyle(.aljLightGreen)
            
            Text(session.notes)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.archivo(with: 20))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    SessionDetailView(session: Session(isMock: true))
}
