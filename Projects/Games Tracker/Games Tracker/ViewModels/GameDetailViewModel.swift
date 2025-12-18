//
//  GameDetailViewModel.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/18/25.
//

import SwiftUI


@Observable
class GameDetailViewModel {
    var newPlayerPresented = false
    
    func addNewPlayer() {
        newPlayerPresented = true
    }
}
