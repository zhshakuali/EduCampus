import SwiftUI

struct ProfileScreen: View {
    
    @State var selectedIndex: Int?
    
    var body: some View {
        VStack(spacing: 40) {
            
            Image("avaImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding()
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: 96, height: 96)
            
            segmentedPicker
            
            VStack {
                switch selectedIndex {
                case 0:
                    AboutMeScreen()
                case 1:
                    ScheduleScreen()
                default:
                    Color.clear
                }
            }
        }
    }
    
    private var segmentedPicker: some View {
        SegmentedPicker(
            ["About me", "Schedules"],
            selectedIndex: $selectedIndex,
            selectionAlignment: .bottom,
            content: { item, isSelected in
                Text(item)
                    .foregroundColor(isSelected ? Color.black : Color.gray )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            },
            selection: {
                VStack(spacing: 0) {
                    Spacer()
                    Color.black.frame(height: 1)
                }
            })
            .onAppear {
                selectedIndex = 0
            }
//            .animation(.easeIn(duration: 0.3), value: selectedIndex)
    }
}


//#Preview {
//    ProfileScreen()
//}
