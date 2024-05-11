import SwiftUI

class AboutMeModel: ObservableObject {
    
    @Published var profile: ProfileModel?
    
    private let networkServes = NetworkService.shared
    
    
    @MainActor
    func getProfile() async {
        profile = await networkServes.getProfile()
    }
}
