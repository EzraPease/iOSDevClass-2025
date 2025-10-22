//
//  QuestionFlowView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI




struct QuestionFlowView: View {
    @Environment(QuizManager.self) var quizManager
    let question: Question
    
    init(question: Question) {
        self.question = question
        print("init \(question.text)")
    }
    
    var body: some View {
        VStack {
            switch question.type {
            case .single:
                SingleQuestionSubview(question: question)
            case .multiple:
                MultipleQuestionSubview(question: question)
            case .ranged:
                RangedQuestionSubview(question: question)
            }
        }
        .onAppear {
            print("On appear hit \(quizManager.currentQuestionIndex)")
            quizManager.currentQuestionIndex = quizManager.questionList.firstIndex(of: question) ?? 0
            print("On appear after-hit \(quizManager.currentQuestionIndex)")// NEED TO FIX - IS SKIPPING RANGEDSUBVIEW
            
            if quizManager.selectedAnswers.count == quizManager.currentQuestionIndex {
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Next") {
                    quizManager.navigationStack.append(quizManager.currentQuestionIndex + 1)
                }
                    
            }
        }
        
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button("", systemImage: "chevron.backward") {
//                    quizManager.removeSelectedAnswer()
//                    quizManager.currentQuestionIndex -= 1
//                }
//            }
//        }
}
}

struct SingleQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    @State private var questionOneIsOn = false
    @State private var questionTwoIsOn = false
    @State private var questionThreeIsOn = false
    @State private var questionFourIsOn = false
    private var cannotContinue: Bool {
        if questionOneIsOn || questionTwoIsOn || questionThreeIsOn || questionFourIsOn {
            return false
        } else {
            return true
        }
    }
    
    let question: Question
    
    @State var selectedAnswer: Int = 0
    
    var body: some View {
        VStack {
            Text(question.text)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                Toggle(isOn: $questionOneIsOn) {
                    Text(question.answers[0].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionOneIsOn) { oldValue, newValue in
                            if newValue {
                                questionTwoIsOn = false
                                questionThreeIsOn = false
                                questionFourIsOn = false
                                
                                selectedAnswer = 0
                            }
                        }
                }
                .padding()
                Toggle(isOn: $questionTwoIsOn) {
                    Text(question.answers[1].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionTwoIsOn) { oldValue, newValue in
                            if newValue {
                                questionOneIsOn = false
                                questionThreeIsOn = false
                                questionFourIsOn = false
                                
                                selectedAnswer = 1
                            }
                            if oldValue {
                                
                            }
                        }
                }
                .padding()
                Toggle(isOn: $questionThreeIsOn) {
                    Text(question.answers[2].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionThreeIsOn) { oldValue, newValue in
                            if newValue {
                                questionOneIsOn = false
                                questionTwoIsOn = false
                                questionFourIsOn = false
                                
                                selectedAnswer = 2
                            }
                        }
                }
                .padding()
                Toggle(isOn: $questionFourIsOn) {
                    Text(question.answers[3].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionFourIsOn) { oldValue, newValue in
                            if newValue {
                                questionOneIsOn = false
                                questionTwoIsOn = false
                                questionThreeIsOn = false
                                
                                selectedAnswer = 3
                            }
                        }
                }
                .padding()
            }
        }
    }
}



struct RangedQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    @State private var rangedSlider: Double = 0
    
    let question: Question
    
    var body: some View {
        VStack {
            Text(question.text)
                .font(.largeTitle)
                .bold()
            Text(question.answers[Int(rangedSlider)].text)
                .padding()
            Slider(value: $rangedSlider, in: 0...4.9)
                .padding()
                .padding()
                .background(.fill)
                .clipShape(RoundedRectangle(cornerRadius: 40))
        }
        .padding()
    }
}


struct MultipleQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    @State private var multipleMVVM = MultipleQuestionViewModel()

    
    let question: Question
    
    var body: some View {
        Text(question.text)
            .font(.largeTitle)
            .bold()
        
        List {
            Group {
                Toggle(isOn: $multipleMVVM.isOn1) {
                    Text(question.answers[0].text)
                }
                Toggle(isOn: $multipleMVVM.isOn2) {
                    Text(question.answers[1].text)
                }
                Toggle(isOn: $multipleMVVM.isOn3) {
                    Text(question.answers[2].text)
                }
                Toggle(isOn: $multipleMVVM.isOn4) {
                    Text(question.answers[3].text)
                }
                Toggle(isOn: $multipleMVVM.isOn5) {
                    Text(question.answers[4].text)
                }
            }
            .padding()
            .bold()
        }
        .background(.fill)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .onAppear {
            multipleMVVM.quiz = quiz
        }
    }
}

struct ResultsView: View {
    var body: some View {
        Text("Results View")
    }
}

#Preview {
    @Previewable @State var quizManager = QuizManager()
    QuestionFlowView(question: QuizManager().questionList[2])
        .environment(quizManager)
}
