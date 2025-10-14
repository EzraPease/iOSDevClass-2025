//
//  QuestionFlowView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI

struct QuestionFlowView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
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
            }
            .padding()
            .background(.fill)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding()
        }
    }
}


struct MultipleQuestionSubview: View {
    @State private var isOn = false
    
    var body: some View {
        NavigationStack {
            Text("Insert Question Here")
            Toggle(isOn: $isOn) {
                Text("Test")
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
    }
}

#Preview {
    RangedQuestionSubview()
}
