//
//  QuizManager.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/22/25.
//

import SwiftUI

@Observable
class QuizManager {
    var navigationStack: [Int] = []
    
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
        
        Question(text: "On a scale from 1-5, how often do you use an iphone?",
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
    
    var currentQuestionIndex: Int = 0 {
        didSet {
            print("currentQuestionIndex didSet: \(currentQuestionIndex)")
        }
    }
    
    var selectedAnswers: [phoneType] = []
    
    
    func selectAnswer(_ answer: phoneType) {
        selectedAnswers.append(answer)
    }
    
    func removeSelectedAnswer() {
        guard selectedAnswers.count >= currentQuestionIndex else { return }
        
        selectedAnswers.remove(at: currentQuestionIndex)
    }
    
    func calculateResults() {
        
    }
}

struct Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.text == rhs.text
    }
    
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
