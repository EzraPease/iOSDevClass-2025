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
//        Question( // Extra Question
//            text: "kjlhliujh do first?",
//            type: .single,
//            answers: [
//                Answer(text: "Go out with friends", type: .SE),
//                Answer(text: "Watch or play something alone", type: .thirteenPro),
//                Answer(text: "Work on a hobby or project", type: .XR),
//                Answer(text: "Play some video games", type: .XR)
//            ]
//        ),
        Question(text: "How often do you use an iphone?",
                 type: .ranged,
                 answers: [
                    Answer(text: "1 - Whats an iPhone?", type: .samsungGalaxyNote7),
                    Answer(text: "2 - I mean... I've held one before", type: .SE),
                    Answer(text: "3 - I use one on occasion, but not all that much", type: .SE),
                    Answer(text: "4 - I use one on a pretty regular basis, but not all the time", type: .thirteenPro),
                    Answer(text: "5 - I use them all day every day", type: .XR),
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
    
    //    var selectedAnswers: [phoneType] = []
    var subSelectedAnswerSingle: [phoneType] = []
    var subSelectedAnswerRanged: [phoneType] = []
    var subSelectedAnswerMulti: [phoneType] = []
    
    
    var resultTitle = ""
    var resultDescription = ""
    
    
    
    
    //    func selectAnswer(_ answer: phoneType) {
    //
    //        selectedAnswers.append(answer)
    //    }
    //
    //    func removeSelectedAnswer() {
    //        guard selectedAnswers.count >= currentQuestionIndex else { return }
    //
    //        selectedAnswers.remove(at: currentQuestionIndex)
    //    }
    
//    func changeAnswers() {
//        resultTitle = ""
//        resultDescription = ""
//        subSelectedAnswerMulti.removeAll()
//        subSelectedAnswerRanged.removeAll()
//        subSelectedAnswerSingle.removeAll()
//        currentQuestionIndex = 0
//        
//        TitleView()
//    }
    
    func resetAnswers() {
        resultTitle = ""
        resultDescription = ""
        
        currentQuestionIndex = 0
        
        subSelectedAnswerMulti.removeAll()
        subSelectedAnswerRanged.removeAll()
        subSelectedAnswerSingle.removeAll()
        
        navigationStack.removeAll()
    }

    
    func calculateResults() {
        var result: phoneType = .thirteenPro
        let all = subSelectedAnswerSingle + subSelectedAnswerRanged + subSelectedAnswerMulti
        
        if all.contains(.samsungGalaxyNote7) {
            let winner: phoneType = .samsungGalaxyNote7
            result = winner
        } else {
            let counts = Dictionary(all.map { ($0, 1) }, uniquingKeysWith: +)
            print("Result Counts: \(counts)")
            let maxCount = counts.values.max() ?? 0
            let mostCommonTypes = counts.filter { $0.value == maxCount }.map { $0.key }
            
            if let winner = all.first(where: { mostCommonTypes.contains($0) }) {
                result = winner
                print("Winner by earliest occurrence: \(winner) with \(maxCount)")
            }
        }
        switch result {
        case .thirteenPro:
            resultTitle = "iPhone 13 Pro"
            resultDescription = "You’re sleek, ambitious, and always chasing the next upgrade in life. People come to you for advice because you know your stuff — and you always look good doing it. You love quality, performance, and a bit of flash, but you’re not just about appearances — you back it up with reliability and confidence. If you were a mood, you’d be “I’ve got this.”"
        case .SE:
            resultTitle = "iPhone SE"
            resultDescription = "Simple, efficient, and low-key brilliant. You don’t need fancy extras to shine — you get the job done and look effortlessly cool while doing it. You’re practical, dependable, and maybe a bit nostalgic for the classics. You value comfort and familiarity but still have that spark of modern energy. You’re proof that less really can be more."
        case .XR:
            resultTitle = "iPhone XR"
            resultDescription = "You’re vibrant, social, and full of personality. You love color, excitement, and anything that makes people smile. You’re not obsessed with perfection — you just want to have a good time. You light up every group chat, and people appreciate your realness. You’re confident, bold, and not afraid to stand out."
        case .samsungGalaxyNote7:
            resultTitle = "Samsung Galaxy Note 7??"
            resultDescription = "You're taking the wrong test if you got this phone"
        }
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
