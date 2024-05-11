import SwiftUI

struct HomeScreen: View {
    
    let rows = [
        GridItem(.fixed(50))
    ]
    
    @State private var isProfilePresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                CoursesView()
            }
            .navigationDestination(
                isPresented: $isProfilePresented,
                destination: {
                    ProfileScreen()
                }
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isProfilePresented = true
                    }, label: {
                        Image(systemName: "person.circle")
                    })
                }
            }
            .tint(.red)
        }
    }
}

//#Preview {
//    HomeScreen()
//}
