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
        guard !playerList.isEmpty else { return nil }

        let leader: Player?

        switch winBy {
        case .highestScore:
            leader = playerList.sorted { $0.score > $1.score }.first
        case .lowestScore:
            leader = playerList.sorted { $0.score < $1.score }.first
        }

        return leader?.name
    }
    var timeStamp: Date = Date.now
    var playerSortBy: NewGameViewModel.PlayerSortMode
    var winBy: NewGameViewModel.PlayerWinMode

    /// Players sorted according to this game's configured sort mode.
    var sortedPlayers: [Player] {
        switch playerSortBy {
        case .highestScore:
            return playerList.sorted { $0.score > $1.score }
        case .lowestScore:
            return playerList.sorted { $0.score < $1.score }
        }
    }
    @Relationship(deleteRule: .cascade) var playerList: [Player]
    
    init(image: String = "dice.fill", gameTitle: String, playerSortBy: NewGameViewModel.PlayerSortMode, winBy: NewGameViewModel.PlayerWinMode, playerList: [Player]) {
        self.image = image
        self.gameTitle = gameTitle
        self.playerSortBy = playerSortBy
        self.winBy = winBy
        self.playerList = playerList
    }
}
