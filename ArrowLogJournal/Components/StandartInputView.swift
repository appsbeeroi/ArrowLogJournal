import SwiftUI

struct StandartInputView: View {
    
    @Binding var text: String
    
    let placeholder: String
    let keyboard: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    init(
        text: Binding<String>,
        placeholder: String,
        keyboard: UIKeyboardType = .numberPad,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboard = keyboard
        self._isFocused = isFocused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text(placeholder)
                .foregroundColor(.aljLightGreen)
                .font(.archivo(with: 20))
            )
            .keyboardType(keyboard)
            .font(.archivo(with: 20))
            .foregroundStyle(.white)
            .focused($isFocused)
            
            if text != "" {
                Button {
                    text = ""
                    isFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.gray.opacity(0.5))
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 8)
        .strokeView()
    }
}
