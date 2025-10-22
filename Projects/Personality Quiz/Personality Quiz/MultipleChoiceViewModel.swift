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
}
