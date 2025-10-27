//
//  ContentView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI

struct TitleView: View {
    @State var quiz = QuizManager()
    var body: some View {
        NavigationStack(path: $quiz.navigationStack) {
            ZStack {
                AppBackground()
                VStack {
                    Image("Iphones")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        .shadow(color: .gray ,radius: 8)
                    
                    Text("Which iPhone Are You?")
                        .font(.largeTitle)
                        .bold()
                        .shadow(color: .gray ,radius: 5, x: 2, y: 1,)
                        .padding()
                    
                    Button {
                        quiz.navigationStack.append(quiz.currentQuestionIndex)
                    } label: {
                        Text("Begin Quiz")
                            .padding()
                            .glassEffect()
                            .background(.white.opacity(0.8))
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 60))
                    }
                }
                .navigationDestination(for: Int.self) { index in
                    if index < quiz.questionList.count {
                        QuestionFlowView(question: quiz.questionList[index])
                    } else {
                        ResultsView()
                    }
                }
            }
        }
        .environment(quiz)
    }
}

#Preview {
    TitleView()
}
