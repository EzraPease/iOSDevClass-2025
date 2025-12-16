//
//  GamesModel.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI
import SwiftData


@Model
class Game: Identifiable {
    var image = "dice.fill"
    var gameTitle: String
    var currentLeader: String
    var timeStamp: Date
    @Relationship(deleteRule: .cascade) var newGame = [NewGameModel]()
    
    init(gameTitle: String, currentLeader: String, timeStamp: Date = .now) {
        self.gameTitle = gameTitle
        self.currentLeader = currentLeader
        self.timeStamp = timeStamp
    }
}
