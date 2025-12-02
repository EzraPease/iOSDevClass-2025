//
//  NewEntryView.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/2/25.
//

import SwiftUI
import SwiftData

struct NewEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var title = ""
    @State private var entryBody = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Title", text: $title)
                }
                Section {
                    TextField("Body", text: $entryBody)
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: save) {
                        Text("Save")
                    }
                }
            }
        }
        
    }
    
    private func save() {
        let newEntry = JournalEntries(title: title, body: entryBody)
            context.insert(newEntry)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
}
