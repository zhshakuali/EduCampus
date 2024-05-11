import SwiftUI

@main
struct PetProjectApp: App {
    
    @StateObject private var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
                .environmentObject(userStateViewModel)
        }
    }
}
