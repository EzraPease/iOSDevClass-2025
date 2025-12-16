//
//  GamesViewModel.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI


@Observable
class GamesViewModel {
    var addPlayerPresented = false
    
    func showAddGameView() {
        addPlayerPresented = true
    }
}
