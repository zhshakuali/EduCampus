import SwiftUI

struct ScheduleScreen: View {
    
    @StateObject var model = ScheduleModel()
    
    var body: some View {
        VStack {
            if let items = model.schedules {
                List(items) { item in
                    ScheduleItemView(item: item)
                }
                .listRowInsets(.none)
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            } else {
                ProgressView()
            }
        }
        .task {
            await model.getSchedule()
        }
    }
}

struct ScheduleItemView: View {
    
    let item: ScheduleEntity.ScheduleElement
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
                    .frame(width: 64, height: 35)
                
                Text(item.hour)
                    .font(.caption)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.module.subject)
                    .font(.headline)
                
                Text(item.module.description)
                    .font(.subheadline)
                    .lineLimit(3)
                
                Text(item.weekday)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
    }
}
