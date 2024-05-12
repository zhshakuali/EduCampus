import SwiftUI

struct QuizItemView: View {
    
    @State private var selection: String?
    
    let data: QuizPageData
    let onNext: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Text(data.question)
                    .font(.bodyMBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 20) {
                    ForEach(data.options.indices, id: \.self) { index in
                        SelectableView(
                            text: "\(letter(for: index)). \(data.options[index])",
                            tag: data.options[index],
                            selection: $selection
                        )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .buttonStack(
            ButtonStack(
                buttons: [
                    .init(
                        title: "Next",
                        isLoading: false,
                        style: .primary,
                        action: {
                            onNext(data.id)
                        }
                    )
                ]
            )
        )
    }
    
    private func letter(for index: Int) -> String {
        switch index {
        case 0:
            return "A"
        case 1:
            return "B"
        case 2:
            return "C"
        case 3:
            return "D"
        case 4:
            return "E"
        default:
            return ""
        }
    }
}

#Preview {
    QuizItemView(
        data: .init(
            id: "id",
            question: "Radio buttons can be used to determine?",
            options: [
                "Gender",
                "Address",
                "Hobby",
                "Educational History",
                "Age"
            ]
        ),
        onNext: { _ in
            
        }
    )
}
