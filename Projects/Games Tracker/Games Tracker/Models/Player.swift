//
//  PlayersCell.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/12/25.
//

import SwiftUI
import SwiftData


@Model
class Player: Identifiable {
    var id = UUID()
    
    var image: String = "person.fill"
    var name: String = ""
    var score: Int = 0
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
