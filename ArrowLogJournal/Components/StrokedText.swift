import SwiftUI

struct StrokedText: View {
    
    let text: String
    let fontSize: CGFloat
    let foregroundColor: Color
    let backgroundColor: Color
    
    init(
        text: String,
        fontSize: CGFloat,
        foregroundColor: Color = .white,
        backgroundColor: Color = .aljGreen
    ) {
        self.text = text
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack {
            Group {
                Text(text)
                    .offset(x: -1)
                   
                Text(text)
                    .offset(x: -1, y: -1)

                Text(text)
                    .offset(x: 1, y: 1)
                
                Text(text)
                    .offset(x: 1, y: -1)
                
                Text(text)
                    .offset(y: 1)
            }
            .foregroundStyle(backgroundColor)
                
            Text(text)
                .foregroundStyle(foregroundColor)
        }
        .font(.archivo(with: fontSize))
    }
}

#Preview {
    StrokedText(text: "Hello world", fontSize: 30)
}
