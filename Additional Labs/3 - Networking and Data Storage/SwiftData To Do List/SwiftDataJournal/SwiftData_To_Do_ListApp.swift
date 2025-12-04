//
//  SwiftData_To_Do_ListApp.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/2/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftData_To_Do_ListApp: App {
    var body: some Scene {
        WindowGroup {
            EntriesView()
        }
        .modelContainer(for: [JournalEntries.self, Journals.self])
    }
}
