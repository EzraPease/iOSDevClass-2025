//
//  HourlyBudgetApp.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/8/26.
//

import SwiftUI
import SwiftData

@main
struct HourlyBudgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Budget.self, Transactions.self], inMemory: true)
    }
}
