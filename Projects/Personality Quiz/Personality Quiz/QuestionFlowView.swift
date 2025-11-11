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
//                    quiz.selectAnswer(quiz.questionList[quiz.currentQuestionIndex].answers[0].type)
                }
                
            }
        }
//        .navigationBarBackButtonHidden(true)
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
        ZStack {
            AppBackground()
        VStack {
            Text(question.text)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                Group {
                    Toggle(isOn: $questionOneIsOn) {
                        Text(question.answers[0].text)
                            .font(.title3)
                            .bold()
                            .onChange(of: questionOneIsOn) { oldValue, newValue in
                                if newValue {
                                    questionTwoIsOn = false
                                    questionThreeIsOn = false
                                    questionFourIsOn = false
                                    
                                    quiz.subSelectedAnswerSingle.removeAll()
                                    quiz.subSelectedAnswerSingle.append(question.answers[0].type)
                                    print(quiz.subSelectedAnswerSingle)
                                }
                            }
                    }
                    Toggle(isOn: $questionTwoIsOn) {
                        Text(question.answers[1].text)
                            .font(.title3)
                            .bold()
                            .onChange(of: questionTwoIsOn) { oldValue, newValue in
                                if newValue {
                                    questionOneIsOn = false
                                    questionThreeIsOn = false
                                    questionFourIsOn = false
                                    
                                    quiz.subSelectedAnswerSingle.removeAll()
                                    quiz.subSelectedAnswerSingle.append(question.answers[1].type)
                                    print(quiz.subSelectedAnswerSingle)
                                }
                            }
                    }
                    Toggle(isOn: $questionThreeIsOn) {
                        Text(question.answers[2].text)
                            .font(.title3)
                            .bold()
                            .onChange(of: questionThreeIsOn) { oldValue, newValue in
                                if newValue {
                                    questionOneIsOn = false
                                    questionTwoIsOn = false
                                    questionFourIsOn = false
                                    
                                    quiz.subSelectedAnswerSingle.removeAll()
                                    quiz.subSelectedAnswerSingle.append(question.answers[2].type)
                                    print(quiz.subSelectedAnswerSingle)
                                }
                            }
                    }
                    Toggle(isOn: $questionFourIsOn) {
                        Text(question.answers[3].text)
                            .font(.title3)
                            .bold()
                            .onChange(of: questionFourIsOn) { oldValue, newValue in
                                if newValue {
                                    questionOneIsOn = false
                                    questionTwoIsOn = false
                                    questionThreeIsOn = false
                                    
                                    quiz.subSelectedAnswerSingle.removeAll()
                                    quiz.subSelectedAnswerSingle.append(question.answers[3].type)
                                    print(quiz.subSelectedAnswerSingle)
                                }
                            }
                    }
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
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
        ZStack {
            AppBackground()
            VStack {
                Text(question.text)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text(question.answers[Int(rangedSlider)].text)
                    .padding()
                Slider(value: $rangedSlider, in: 0...Double(quiz.questionList[1].answers.count) - 0.1)
                    .padding()
                    .padding()
                    .background(.fill)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
            .padding()
            .onDisappear {
                quiz.subSelectedAnswerRanged.append(question.answers[Int(rangedSlider)].type)
                print("Ranged Array: \(quiz.subSelectedAnswerRanged)")
            }
            .onAppear {
                quiz.subSelectedAnswerRanged.removeAll()
                print("Ranged Array: \(quiz.subSelectedAnswerRanged)")
            }
        }
    }
}


struct MultipleQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    @State private var multipleMVVM = MultipleQuestionViewModel()
    
    
    let question: Question
    
    var body: some View {
        ZStack {
            AppBackground()
            VStack {
                Text(question.text)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                
                List {
                    Group {
                        Toggle(isOn: $multipleMVVM.isOn1) {
                            Text(question.answers[0].text)
                                .onChange(of: multipleMVVM.isOn1) { oldValue, newValue in
                                    if newValue {
                                        multipleMVVM.insertValue(answerNumber: 0)
                                        print(quiz.subSelectedAnswerMulti)
                                    } else if oldValue {
                                        multipleMVVM.removeValue(value: 0)
                                        print(quiz.subSelectedAnswerMulti)
                                    }
                                }
                        }
                        Toggle(isOn: $multipleMVVM.isOn2) {
                            Text(question.answers[1].text)
                                .onChange(of: multipleMVVM.isOn2) { oldValue, newValue in
                                    if newValue {
                                        multipleMVVM.insertValue(answerNumber: 1)
                                        print(quiz.subSelectedAnswerMulti)
                                    } else if oldValue {
                                        multipleMVVM.removeValue(value: 1)
                                        print(quiz.subSelectedAnswerMulti)
                                    }
                                }
                        }
                        Toggle(isOn: $multipleMVVM.isOn3) {
                            Text(question.answers[2].text)
                                .onChange(of: multipleMVVM.isOn3) { oldValue, newValue in
                                    if newValue {
                                        multipleMVVM.insertValue(answerNumber: 2)
                                        print(quiz.subSelectedAnswerMulti)
                                    } else if oldValue {
                                        multipleMVVM.removeValue(value: 2)
                                        print(quiz.subSelectedAnswerMulti)
                                    }
                                }
                        }
                        Toggle(isOn: $multipleMVVM.isOn4) {
                            Text(question.answers[3].text)
                                .onChange(of: multipleMVVM.isOn4) { oldValue, newValue in
                                    if newValue {
                                        multipleMVVM.insertValue(answerNumber: 3)
                                        print(quiz.subSelectedAnswerMulti)
                                    } else if oldValue {
                                        multipleMVVM.removeValue(value: 3)
                                        print(quiz.subSelectedAnswerMulti)
                                    }
                                }
                        }
                        Toggle(isOn: $multipleMVVM.isOn5) {
                            Text(question.answers[4].text)
                                .onChange(of: multipleMVVM.isOn5) { oldValue, newValue in
                                    if newValue {
                                        multipleMVVM.insertValue(answerNumber: 4)
                                        print(quiz.subSelectedAnswerMulti)
                                    } else if oldValue {
                                        multipleMVVM.removeValue(value: 4)
                                        print(quiz.subSelectedAnswerMulti)
                                    }
                                }
                        }
                    }
                    .padding()
                    .bold()
                }
                .scrollContentBackground(.hidden)
                .onAppear {
                    multipleMVVM.quiz = quiz
                }
            }
        }
    }
}

struct ResultsView: View {
    @Environment(QuizManager.self) var quiz
    
    
    var body: some View {
            ZStack {
                AppBackground()
                VStack {
                    Text("You're a...")
                        .font(.headline)
                        .bold()
                    Text(quiz.resultTitle)
                        .font(.largeTitle)
                        .bold()
                    Text("\(quiz.resultDescription)")
                        .foregroundStyle(.black)
                        .italic()
                        .padding()
                        .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 45))
                        .padding()
            }
            .onAppear {
                quiz.calculateResults()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    @Previewable @State var quizManager = QuizManager()
    QuestionFlowView(question: QuizManager().questionList[1])
//    ResultsView()
        .environment(quizManager)
}



