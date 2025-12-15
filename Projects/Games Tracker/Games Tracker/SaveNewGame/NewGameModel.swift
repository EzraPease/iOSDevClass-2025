//
//  NewGameModel.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/12/25.
//

import SwiftData


@Model
class NewGameModel {
    var sortBy: NewGameViewModel.PlayerSortMode
    var winBy: NewGameViewModel.PlayerWinMode
    var playerList: [PlayersCell]
    var games: Game?
    
    init(sortBy: NewGameViewModel.PlayerSortMode, winBy: NewGameViewModel.PlayerWinMode, playerList: [PlayersCell]) {
        self.sortBy = sortBy
        self.winBy = winBy
        self.playerList = playerList
    }
}
