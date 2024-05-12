import SwiftUI

struct TextFieldComponent: View {
    
    let placeholder: String
    let isPassword: Bool
    @Binding var text: String
    
    init(
        placeholder: String,
        isPassword: Bool = false,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.isPassword = isPassword
        self._text = text
    }
    
    var body: some View {
        Group {
            if isPassword {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .textFieldStyle(.roundedBorder)
    }
}

//#Preview {
//    TextFieldComponent(
//        placeholder: "",
//        isPassword: false,
//        text: .constant("")
//    )
//}
