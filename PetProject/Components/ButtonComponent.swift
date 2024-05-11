import SwiftUI

struct ButtonComponent: View {
    
    let title: String
    let style: ButtonComponentStyle
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text(title)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        )
        .buttonStyle(style)
        .disabled(isLoading)
    }
}

struct ButtonComponentStyle: ButtonStyle {
    
    let background: Color
    let foreground: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(background)
            .foregroundStyle(foreground)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(
                .easeOut(duration: 0.1),
                value: configuration.isPressed
            )
    }
}

extension ButtonStyle where Self == ButtonComponentStyle {
    
    static var primary: ButtonComponentStyle {
        ButtonComponentStyle(background: .red, foreground: .white)
    }
    
    static var secondary: ButtonComponentStyle {
        ButtonComponentStyle(background: .clear, foreground: .blue)
    }
    
}

//#Preview {
//    Button {
//        
//    } label: {
//        Text("Button")
//            .frame(maxWidth: .infinity)
//    }
//    .buttonStyle(.primary)
//    .padding()
//}
