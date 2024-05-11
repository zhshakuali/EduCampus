import SwiftUI

struct AboutMeScreen: View {
    @StateObject var model = AboutMeModel()
    var body: some View {
        List {
            if let profile = model.profile {
                Section("User Information") {
                    userInfomationSection(profile)
                }
                
                Section("Creation Time") {
                    creationTimeSecion(profile)
                }
                
              
            } else {
                ProgressView()
            }
        }
        .task {
            await model.getProfile()
        }
    }
    
    @ViewBuilder
    private func userInfomationSection(_ profile: ProfileModel) -> some View {
        textCell(
            "Email address",
            subtitle: "\(profile.data.user.id)@iitu.edu.kz"
        )
        textCell(
            "Specialization",
            subtitle: profile.data.user.student.specialization
        )
        textCell(
            "Faculty",
            subtitle: profile.data.user.student.faculty
        )
    }
    
    @ViewBuilder
    private func creationTimeSecion(_ profile: ProfileModel) -> some View {
        textCell(
            "First access to site",
            subtitle: profile.data.user.createdAtDate
        )
        textCell(
            "Last access to site",
            subtitle: profile.data.user.updatedAtDate
        )
    }
    
    private func textCell(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(subtitle)
        }
    }
}

//#Preview {
//    AboutMeScreen()
//}
