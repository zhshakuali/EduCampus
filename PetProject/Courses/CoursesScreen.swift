
import SwiftUI


struct CoursesView: View {
    
    @StateObject var model = CoursesModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let course = model.course {
                VSpacer(20)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Course progress")
                        .font(.headline)
                    
                    Text("Group: \(course.groupInfo.group)")
                        .font(.caption)
                }
                .padding(.horizontal, 20)
                
                List(course.modules) { item in
                    CourseItemView(item: item)
                }
                .listRowInsets(.none)
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            } else {
                ProgressView()
            }
        }
        .task {
            await model.getCourses()
        }
    }
}

struct CourseItemView: View {
    
    let item: CourseEntity.Module
    
    var body: some View {
        HStack(spacing: 20) {
            Image("moduleImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 106, height: 135)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.subject)
                        .font(.headline)
                    
                    Text(item.description)
                        .font(.callout)
                        .lineLimit(3)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    ProgressView(value: 80, total: 100)
                        .tint(.red)
                    Text("\(80) % Complete")
                }
            }
        }
    }
    
    
//    func color(fraction: Double) -> Color {
//            Color(red: fraction, green: 1 - fraction, blue: 0.5)
//    }
}
