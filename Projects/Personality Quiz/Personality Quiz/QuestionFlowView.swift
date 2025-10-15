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



class QuizManager {
    let questionList: [Question] = [
        Question(
            text: "When you have free time, what do you usually do first?",
            type: .single,
            answers: [
                Answer(text: "Go out with friends", type: .SE),
                Answer(text: "Watch or play something alone", type: .thirteenPro),
                Answer(text: "Work on a hobby or project", type: .XR)
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
            
        ),
        
        Question(text: "Insert Question",
                 type: .ranged,
                 answers: [
                    
                 ]
                )
    ]
}


struct QuestionFlowView: View {
    var body: some View {
        
    }
    
    
    
    struct SingleQuestionSubview: View {
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
        
        var body: some View {
            NavigationStack {
                List {
                    Toggle(isOn: $questionOneIsOn) {
                        Text("Question 1")
                            .font(.title3)
                            .bold()
                            .onChange(of: questionOneIsOn) { newValue, oldValue in
                                if !newValue {
                                    questionTwoIsOn = false
                                    questionThreeIsOn = false
                                    questionFourIsOn = false
                                }
                            }
                    }
                    .padding()
                    Toggle(isOn: $questionTwoIsOn) {
                        Text("Question 2")
                            .font(.title3)
                            .bold()
                            .onChange(of: questionTwoIsOn) { newValue, oldValue in
                                if !newValue {
                                    questionOneIsOn = false
                                    questionThreeIsOn = false
                                    questionFourIsOn = false
                                }
                            }
                    }
                    .padding()
                    Toggle(isOn: $questionThreeIsOn) {
                        Text("Question 3")
                            .font(.title3)
                            .bold()
                            .onChange(of: questionThreeIsOn) { newValue, oldValue in
                                if !newValue {
                                    questionOneIsOn = false
                                    questionTwoIsOn = false
                                    questionFourIsOn = false
                                }
                            }
                    }
                    .padding()
                    Toggle(isOn: $questionFourIsOn) {
                        Text("Question 4")
                            .font(.title3)
                            .bold()
                            .onChange(of: questionFourIsOn) { newValue, oldValue in
                                if !newValue {
                                    questionOneIsOn = false
                                    questionTwoIsOn = false
                                    questionThreeIsOn = false
                                }
                            }
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                RangedQuestionSubview()
                            } label: {
                                Text("Next")
                            }
                            .disabled(cannotContinue)
                        }
                    }
                }
            }
        }
    }
    
    struct RangedQuestionSubview: View {
        @State private var rangedSlider: Double = 0
        
        var body: some View {
            NavigationStack {
                VStack {
                    Text("How much do you enjoy iPhones?")
                        .font(.largeTitle)
                        .bold()
                    Text("\(Int(rangedSlider))")
                    Slider(value: $rangedSlider, in: 0...10)
                        .padding()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink {
                                    MultipleQuestionSubview()
                                } label: {
                                    Text("Next")
                                }
                            }
                        }
                        .padding()
                        .background(.fill)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                .padding()
            }
        }
    }
    
    
    struct MultipleQuestionSubview: View {
        
        
        @State private var isOn1 = false
        @State private var isOn2 = false
        @State private var isOn3 = false
        @State private var isOn4 = false
        @State private var isOn5 = false
        
        var body: some View {
            NavigationStack {
                Text("Which prompt best describes you?")
                    .font(.largeTitle)
                    .bold()
                //                List($multipleChoiceQuestions) { $questions in
                //                    Toggle(isOn: $isOn) {
                //                        Text(questions.questions)
                //                    }
                //                }
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
                            NavigationLink {
                                ResultsView()
                            } label: {
                                Text("Next")
                            }
                        }
                    }
                }
                .background(.fill)
                .clipShape(RoundedRectangle(cornerRadius: 40))
            }
            .padding()
        }
    }
}

#Preview {
    QuestionFlowView.MultipleQuestionSubview()
}
