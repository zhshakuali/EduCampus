import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    @StateObject private var model = LoginModel()
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                VSpacer(40)
                
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextFieldComponent(
                    placeholder: "Student ID",
                    text: $model.studentID
                )
                
                TextFieldComponent(
                    placeholder: "Password",
                    isPassword: true,
                    text: $model.password
                )
                
                ButtonComponent(
                    title: "Log In",
                    style: .primary,
                    isLoading: model.isLoading,
                    action: {
                        Task { @MainActor in
                            
                            errorMessage = nil
                            let result = await model.login()
                            
                            if let message = result.message {
                                errorMessage = message
                            } else if result.result {
                                vm.isLoggedIn = true
                            } else {
                                errorMessage = "Something went wrong"
                            }
                        }
                    }
                )
                
                VStack {
                    if let errorMessage {
                        Text(errorMessage)
                    }
                }
                .frame(height: 22)
            }
            .padding(.horizontal, 20)
        }
    }
}

//#Preview {
//    LoginScreen()
//}
