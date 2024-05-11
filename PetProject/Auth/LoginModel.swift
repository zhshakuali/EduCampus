import SwiftUI

final class LoginModel: ObservableObject {
    
    @Published var studentID = ""
    @Published var password = ""
    @Published var isLoading = false
    
    private let networkService = NetworkService.shared
    
    @MainActor
    func login() async -> (result: Bool, message: String?) {
        isLoading = true
        let result = await networkService.login(id: studentID, password: password)
        isLoading = false
        
        return result
    }
}
