import SwiftUI

struct ButtonStack: View {
    
    struct Configuration: Identifiable {
        let id = UUID()
        let title: String
        let isLoading: Bool
        let style: ButtonComponentStyle
        let action: () -> Void
        
        init(
            title: String,
            isLoading: Bool,
            style: ButtonComponentStyle,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.isLoading = isLoading
            self.style = style
            self.action = action
        }
    }
    
    let buttons: [Configuration]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(buttons) { button in
                Button(action: button.action, label: {
                    Text(button.title)
                        .frame(maxWidth: .infinity)
                })
                .loading(button.isLoading)
                .buttonStyle(button.style)
            }
        }
        .padding(.horizontal, 20)
    }
}

extension View {
    func buttonStack(
        _ buttons: ButtonStack
    ) -> some View {
        safeAreaInset(edge: .bottom) {
            buttons
        }
    }
}

#Preview {
    ScrollView {
        Text("Some content")
    }
    .safeAreaInset(edge: .bottom) {
        ButtonStack(buttons: [
            .init(title: "First button", isLoading: false, style: .primary, action: {
                
            }),
            .init(title: "Second button", isLoading: false, style: .secondary, action: {
                
            }),
            .init(title: "Second button", isLoading: true, style: .secondary, action: {
                
            })
        ])
    }
}
