//
//  QuestionFlowView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI



struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: phoneType
}

enum phoneType {
    case thirteenPro, SE, XR, samsungGalaxyNote7
}



@Observable
class QuizManager {
    let questionList: [Question] = [
        Question(
            text: "When you have free time, what do you usually do first?",
            type: .single,
            answers: [
                Answer(text: "Go out with friends", type: .SE),
                Answer(text: "Watch or play something alone", type: .thirteenPro),
                Answer(text: "Work on a hobby or project", type: .XR),
                Answer(text: "Play some video games", type: .XR)
            ]
        ),
        
        Question(text: "On a scale fro 1-5, how often do you use an iphone?",
                 type: .ranged,
                 answers: [
                    Answer(text: "1 - Whats an iPhone?", type: .samsungGalaxyNote7),
                    Answer(text: "2 - I mean... I've held one before", type: .SE),
                    Answer(text: "3 - I use one on occasion, but not all that much", type: .SE),
                    Answer(text: "4 - I use one on a pretty regular basis, but not all the time", type: .thirteenPro),
                    Answer(text: "5 - I use them all day every day", type: .XR)
                 ]
                ),
        
        Question(
            text: "When making a big decision, you rely on… (Select all that apply)",
            type: .multiple,
            answers: [
                Answer(text: "Logic and facts", type: .XR),
                Answer(text: "Feelings and intuition", type: .SE),
                Answer(text: "What others recommend", type: .thirteenPro),
                Answer(text: "Past experiences", type: .XR),
                Answer(text: "Whatever feels right in the moment", type: .SE)
            ]
            
        )
        
    ]
    
    var currentQuestion: Int = 0
    var selectedAnswers: [phoneType] = []
    
    
    func selectAnswer(_ answer: phoneType) {
        selectedAnswers.append(answer)
    }
    
    func removeSelectedAnswer() {
        guard selectedAnswers.count >= currentQuestion else { return }
        
        selectedAnswers.remove(at: currentQuestion)
    }
}



struct QuestionFlowView: View {
    @State var quizManager = QuizManager()
    
    var body: some View {
        NavigationStack {
            Group {
                switch quizManager.currentQuestion {
                case 0:
                    SingleQuestionSubview()
                case 1:
                    RangedQuestionSubview()
                case 2:
                    MultipleQuestionSubview()
                case 3:
                    ResultsView()
                default:
                    TitleView()
                }
            }
            .environment(quizManager)
        }
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
    
    @State private var selectedAnswer: Int = 0
    
    var body: some View {
        VStack {
            Text(quiz.questionList[quiz.currentQuestion].text)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                Toggle(isOn: $questionOneIsOn) {
                    Text(quiz.questionList[quiz.currentQuestion].answers[0].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionOneIsOn) { oldValue, newValue in
                            if newValue {
                                questionTwoIsOn = false
                                questionThreeIsOn = false
                                questionFourIsOn = false
                                
//                                wasOn1 = true
                                
                                selectedAnswer = 0
                            }
                        }
                }
                .padding()
                Toggle(isOn: $questionTwoIsOn) {
                    Text(quiz.questionList[quiz.currentQuestion].answers[1].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionTwoIsOn) { oldValue, newValue in
                            if newValue {
                                questionOneIsOn = false
                                questionThreeIsOn = false
                                questionFourIsOn = false
                                
//                                wasOn2 = true
                                
                                selectedAnswer = 1
                            }
                            if oldValue {
                                
                            }
                        }
                }
                .padding()
                Toggle(isOn: $questionThreeIsOn) {
                    Text(quiz.questionList[quiz.currentQuestion].answers[2].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionThreeIsOn) { oldValue, newValue in
                            if newValue {
                                questionOneIsOn = false
                                questionTwoIsOn = false
                                questionFourIsOn = false
                                
//                                wasOn3 = true
                                
                                selectedAnswer = 2
                            }
                        }
                }
                .padding()
                Toggle(isOn: $questionFourIsOn) {
                    Text(quiz.questionList[quiz.currentQuestion].answers[3].text)
                        .font(.title3)
                        .bold()
                        .onChange(of: questionFourIsOn) { oldValue, newValue in
                            if newValue {
                                questionOneIsOn = false
                                questionTwoIsOn = false
                                questionThreeIsOn = false
                                
//                                wasOn4 = true
                                
                                selectedAnswer = 3
                            }
                        }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Next") {
                            quiz.currentQuestion += 1
                            quiz.selectedAnswers.append(quiz.questionList[quiz.currentQuestion].answers[selectedAnswer].type)
                        }
                        .disabled(cannotContinue)
                    }
                }
            }
        }
    }
}



struct RangedQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    @State private var rangedSlider: Double = 0
    
    var body: some View {
        VStack {
            Text(quiz.questionList[quiz.currentQuestion].text)
                .font(.largeTitle)
                .bold()
            Text("\(Int(rangedSlider))")
            Slider(value: $rangedSlider, in: 0...5)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Next") {
                            quiz.currentQuestion += 1
//                            quiz.selectedAnswers.append()
                        }
                    }
                }
                .padding()
                .background(.fill)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("", systemImage: "chevron.backward") {
                            quiz.selectedAnswers.removeLast()
                            quiz.currentQuestion -= 1
                        }
                    }
                }
        }
        .padding()
    }
}


struct MultipleQuestionSubview: View {
    @Environment(QuizManager.self) var quiz
    
    @State private var isOn1 = false
    @State private var isOn2 = false
    @State private var isOn3 = false
    @State private var isOn4 = false
    @State private var isOn5 = false
    
    var body: some View {
        Text("Which prompt best describes you?")
            .font(.largeTitle)
            .bold()
        
        List {
            Toggle(isOn: $isOn1) {
                Text("I prefer working in a team rather than alone")
            }
            Toggle(isOn: $isOn2) {
                Text("I make decisions based on data more than intuition")
            }
            Toggle(isOn: $isOn3) {
                Text("I enjoy trying new activities outside my comfort zone")
            }
            Toggle(isOn: $isOn4) {
                Text("I like to plan everything in advance")
            }
            Toggle(isOn: $isOn5) {
                Text("I stay calm and collected under pressure")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Next") {
                        quiz.currentQuestion += 1
                    }
                }
            }
        }
        .background(.fill)
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

struct ResultsView: View {
    var body: some View {
        Text("Results View")
    }
}

#Preview {
    QuestionFlowView()
}
