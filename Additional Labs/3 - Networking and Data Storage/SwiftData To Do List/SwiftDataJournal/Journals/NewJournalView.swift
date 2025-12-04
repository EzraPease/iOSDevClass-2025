//
//  NewJournalView.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/4/25.
//

import SwiftUI
import SwiftData



struct NewJournalView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var title = ""
    @State private var journalBody = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Title", text: $title)
                }
                Section {
                    TextEditor(text: $journalBody)
                        .frame(height: 200)
                }
            }
            .navigationTitle("New Journal")
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
        let newJournal = Journals(title: title, body: journalBody)
            context.insert(newJournal)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
}
