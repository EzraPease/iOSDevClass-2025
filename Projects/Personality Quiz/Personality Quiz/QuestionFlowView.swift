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
    
    var body: some View {
        NavigationStack {
            Toggle(isOn: $questionOneIsOn) {
                Text("Question 1")
                    .font(.title3)
                    .bold()
            }
                .padding()
            Toggle(isOn: $questionTwoIsOn) {
                Text("Question 2")
                    .font(.title3)
                    .bold()
            }
                .padding()
            Toggle(isOn: $questionThreeIsOn) {
                Text("Question 3")
                    .font(.title3)
                    .bold()
            }
                .padding()
            Toggle(isOn: $questionFourIsOn) {
                Text("Question 4")
                    .font(.title3)
                    .bold()
            }
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
    }
}

struct RangedQuestionSubview: View {
    var body: some View {
        NavigationStack {
            Text("Insert Question Here")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SingleQuestionSubview()
                        } label: {
                            Text("Next")
                        }
                    }
                }
        }
    }
}


struct MultipleQuestionSubview: View {
    var body: some View {
        NavigationStack {
            Text("Insert Question Here")
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
    SingleQuestionSubview()
}
