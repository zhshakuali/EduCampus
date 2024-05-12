import SwiftUI

struct SelectableView<Tag: Equatable>: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    @State private var isPressed = false
    
    let text: String
    let tag: Tag
    @Binding var selection: Tag?
    
    var body: some View {
        Text(text)
            .font(.bodyM)
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTouchGesture(isPressed: $isPressed) {
                selection = selection == tag ? nil : tag
            }
    }
}

private extension SelectableView {
    private enum _State {
        case base
        case basePressed
        case active
        case activePressed
        case disabled
    }
    
    private func getState() -> _State {
        switch (isEnabled, selection == tag, isPressed) {
        case (true, false, false):
            return .base
        case (true, false, true):
            return .basePressed
        case (true, true, false):
            return .active
        case (true, true, true):
            return .activePressed
        case (false, _, _):
            return .disabled
        }
    }
    
    var backgroundColor: Color {
        switch getState() {
        case .base:
            return .Background.neutral1.color
        case .basePressed:
            return .Background.neutral2.color
        case .active:
            return .Background.accent.color
        case .activePressed:
            return .Background.accentPressed.color
        case .disabled:
            return .Background.neutral1.color
        }
    }
    
    var foregroundColor: Color {
        switch getState() {
        case .base:
            return .Text.primary.color
        case .basePressed:
            return .Text.primary.color
        case .active:
            return .Text.primaryOnDark.color
        case .activePressed:
            return .Text.primaryOnDark.color
        case .disabled:
            return .Text.tertiary.color
        }
    }
}

#Preview {
    SelectableViewPreview()
}

private struct SelectableViewPreview: View {
    @State var selection: String?
    
    var body: some View {
        VStack {
            SelectableView(text: "First", tag: "tag_1", selection: $selection)
            SelectableView(text: "Second", tag: "tag_2", selection: $selection)
        }
        .padding()
    }
}
