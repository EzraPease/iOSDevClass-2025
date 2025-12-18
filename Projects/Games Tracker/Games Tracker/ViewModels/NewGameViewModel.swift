//
//  NewGameViewModel.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/12/25.
//

import SwiftUI



@Observable
class NewGameViewModel {
    var newPlayerPresented = false
    
    enum PlayerSortMode: Codable {
        case highestScore
        case lowestScore
    }
    enum PlayerWinMode: Codable {
        case highestScore
        case lowestScore
    }
}
