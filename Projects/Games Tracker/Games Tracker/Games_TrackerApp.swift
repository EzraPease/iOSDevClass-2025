//
//  Games_TrackerApp.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI
import SwiftData

@main
struct Games_TrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            GamesTableView()
        }
        .modelContainer(for: [GamesModel.self])
    }
}
