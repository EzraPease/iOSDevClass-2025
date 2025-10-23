//
//  MvvM.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/21/25.
//

import SwiftUI


@Observable class MultipleQuestionViewModel {
    var quiz: QuizManager?
    
    var isOn1 = false
    var isOn2 = false
    var isOn3 = false
    var isOn4 = false
    var isOn5 = false
    
    func insertValue(answerNumber index: Int) {
        quiz?.subSelectedAnswerMulti.append(quiz!.questionList[2].answers[index].type)
    }
    
    func removeValue(value index: Int) {
        if let valueCheck = quiz?.subSelectedAnswerMulti.firstIndex(of: quiz!.questionList[2].answers[index].type) {
            quiz?.subSelectedAnswerMulti.remove(at: valueCheck)
        }
    }
}
