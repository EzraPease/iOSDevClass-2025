//
//  ContentView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI

struct TitleView: View {
    @State var quizManager = QuizManager()
    var body: some View {
        NavigationStack(path: $quizManager.navigationStack) {
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
                        quizManager.navigationStack.append(quizManager.currentQuestionIndex)
                    } label: {
                        Text("Begin Quiz")
                            .padding()
                            .glassEffect()
                            .background(.gray)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 60))
                    }
                }
                .navigationDestination(for: Int.self) { index in
                    if index < quizManager.questionList.count {
                        QuestionFlowView(question: quizManager.questionList[index])
                    } else {
                        ResultsView()
                    }
                }
        }
        .environment(quizManager)
    }
}

#Preview {
    TitleView()
}
