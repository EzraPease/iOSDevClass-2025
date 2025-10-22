//
//  QuestionFlowView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI




struct QuestionFlowView: View {
    @Environment(QuizManager.self) var quiz
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
//            print("On appear hit \(quizManager.currentQuestionIndex)")
            quiz.currentQuestionIndex = quiz.questionList.firstIndex(of: question) ?? 0
//            print("On appear after-hit \(quizManager.currentQuestionIndex)")
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Next") {
                    quiz.navigationStack.append(quiz.currentQuestionIndex + 1)
                    quiz.selectAnswer(quiz.questionList[quiz.currentQuestionIndex].answers[0].type)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SingleQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    @State private var questionOneIsOn = false
    @State private var questionTwoIsOn = false
    @State private var questionThreeIsOn = false
    @State private var questionFourIsOn = false
//    private var cannotContinue: Bool {
//        if questionOneIsOn || questionTwoIsOn || questionThreeIsOn || questionFourIsOn {
//            return false
//        } else {
//            return true
//        }
//    }
//    
    let question: Question
    
    
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
        VStack {
        Text("Results View")
    }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @Previewable @State var quizManager = QuizManager()
    QuestionFlowView(question: QuizManager().questionList[2])
        .environment(quizManager)
}
