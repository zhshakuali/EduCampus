import SwiftUI

final class UserStateViewModel: ObservableObject {
    @Published var isLoggedIn = false
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if vm.isLoggedIn {
            HomeScreen()
        } else {
            LoginScreen()
        }
    }
}
