import SwiftUI

struct QuizPageData: Hashable {
    let id: String
    let question: String
    let options: [String]
}

struct QuizProcessScreen: View {
    
    @State
    private var path = NavigationPath()
    
    private var currentPageNumber: Int {
        guard !path.isEmpty else { return 1 }
        
        return path.count + 1
    }
    
    let pages: [QuizPageData]
    
    var body: some View {
        NavigationStack(path: $path) {
            initialPage
                .navigationDestination(for: QuizPageData.self) { page in
                    QuizItemView(
                        data: page,
                        onNext: nextPage
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        currentPageToolbar
                        timeToolbar
                    }
                }
        }
    }
    
    @ViewBuilder
    private var initialPage: some View {
        if let page = pages.first {
            QuizItemView(
                data: page,
                onNext: nextPage
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                currentPageToolbar
                timeToolbar
            }
        } else {
            Text("Can't load quiz")
        }
    }
    
    private var currentPageToolbar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Question \(currentPageNumber) of \(pages.count)")
        }
    }
    
    private var timeToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack {
                Image(systemName: "clock")
                Text("15:00")
            }
        }
    }
    
    private func nextPage(_ id: String) {
        guard
            let currentIndex = pages.firstIndex(where: { $0.id == id }),
            pages.indices.contains(currentIndex + 1)
        else {
            return
        }
        
        path.append(pages[currentIndex + 1])
    }
}

#Preview {
    QuizProcessScreenPreview()
}

private struct QuizProcessScreenPreview: View {
    @State var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Text("Show quiz")
        })
        .buttonStyle(.primary.standard)
        .sheet(isPresented: $isPresented, content: {
            QuizProcessScreen(
                pages: [
                    .init(
                        id: "q_1",
                        question: "Question 1",
                        options: [
                            "Q1. Option 1"
                        ]
                    ),
                    .init(
                        id: "q_2",
                        question: "Question 2",
                        options: [
                            "Q2. Option 1",
                            "Q2. Option 2"
                        ]
                    ),
                    .init(
                        id: "q_3",
                        question: "Question 3",
                        options: [
                            "Q3. Option 1",
                            "Q3. Option 2",
                            "Q3. Option 3"
                        ]
                    )
                ]
            )
        })
    }
}
