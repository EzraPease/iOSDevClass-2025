//
//  Interview_App_Monday_2_23App.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import SwiftUI
import SwiftData

@main
struct Interview_App_Monday_2_23App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self])
    }
}
