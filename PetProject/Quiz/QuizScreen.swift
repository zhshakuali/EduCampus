import SwiftUI

@Observable
final class QuizModel {
    private(set) var description = """
    Please complete this quiz within 15 minutes
    as the first grade of the quiz component.
    Don't forget to click the Submit Answer button after answering
    all questions.

    Do it before Friday, February 26 2021 at 23:59
    """
    
    private(set) var info = """
    Quiz will close on Friday, 26 February 2021, 11:59 PM

    Time Limit: 15 minutes

    Grading Method: Highest Score
    """
    
    private(set) var finalScoreDescription: String? = "Your Final Score For This Quiz Is 85.0 / 100.00"
}

struct QuizScreen: View {
    
    @State var model = QuizModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text(model.description)
                    .font(.bodyM)
                
                VSpacer(20)
                
                Text(model.info)
                    .font(.bodyM)
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(Color.Background.elevation.color)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VSpacer(20)
            }
        }
        .padding(.horizontal, 20)
        .background(Color.Background.base.color)
        .buttonStack(
            ButtonStack(buttons: [
                .init(
                    title: "Take the Quiz",
                    isLoading: false,
                    style: .primary.standard,
                    action: {
                        
                    }
                )
            ])
        )
    }
}

#Preview {
    QuizScreen()
}
