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
    var image: String
    var gameTitle: String
    var currentLeader: String? {
        if let player = playerList.first {
            return player.name
        } else {
            return nil
        }
        
    }
    var timeStamp: Date = Date.now
    var playerSortBy: NewGameViewModel.PlayerSortMode
    var winBy: NewGameViewModel.PlayerWinMode
    var playerList: [Player]
    
    init(image: String = "dice.fill", gameTitle: String, playerSortBy: NewGameViewModel.PlayerSortMode, winBy: NewGameViewModel.PlayerWinMode, playerList: [Player]) {
        self.image = image
        self.gameTitle = gameTitle
        self.playerSortBy = playerSortBy
        self.winBy = winBy
        self.playerList = playerList
    }
}
