import SwiftUI

struct AddSessionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: SessionsViewModel
    
    @State var session: Session
    @State var hasDateSelected: Bool
    
    @State private var isShowDatePicker = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.baseBG)
                .resizeAndAdopt()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        dateSelector
                        
                        HStack(spacing: 12) {
                            StandartInputView(text: $session.series, placeholder: "Series", isFocused: $isFocused)
                            StandartInputView(text: $session.shots, placeholder: "Shots", isFocused: $isFocused)
                        }
                        
                        HStack(spacing: 12) {
                            StandartInputView(text: $session.hits, placeholder: "Hits", isFocused: $isFocused)
                            StandartInputView(text: $session.near, placeholder: "Near", isFocused: $isFocused)
                        }
                        
                        HStack(spacing: 12) {
                            StandartInputView(text: $session.miss, placeholder: "Miss", isFocused: $isFocused)
                            StandartInputView(text: $session.distance, placeholder: "Distance", isFocused: $isFocused)
                        }
                        
                        StandartInputView(
                            text: $session.notes,
                            placeholder: "Notes",
                            keyboard: .default,
                            isFocused: $isFocused
                        )
                    }
                    .padding(.top, 5)
                    .padding(.horizontal, 35)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Button("Done") {
                                    isFocused = false
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            
            if isShowDatePicker {
                datePicker
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.smooth, value: isShowDatePicker)
        .onChange(of: session.date) { _ in
            hasDateSelected = true
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
            
            StrokedText(text: "Add\nsession", fontSize: 35)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Button {
                viewModel.save(session)
            } label: {
                Image(.Icons.checkmark)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .opacity(session.isLock ? 0.5 : 1)
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var dateSelector: some View {
        Button {
            isShowDatePicker = true
        } label: {
            HStack {
                let date = session.date.formatted(.dateTime.year().month(.twoDigits).day())
                
                Text(hasDateSelected ? date : "Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.archivo(with: 20))
                    .foregroundStyle(.white)
                
                Image(.Icons.calendar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .frame(minHeight: 60)
            .padding(.horizontal, 10)
            .strokeView()
        }
    }
    
    private var datePicker: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button("Done") {
                        isShowDatePicker = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                
                DatePicker("", selection: $session.date, displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
            }
            .padding()
        }
    }
}

#Preview {
    AddSessionView(session: Session(isMock: false), hasDateSelected: false)
        .environmentObject(SessionsViewModel())
}

