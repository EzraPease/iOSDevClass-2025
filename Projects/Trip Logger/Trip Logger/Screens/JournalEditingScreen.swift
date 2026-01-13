//
//  JournalEditingView.swift
//  Trip Logger
//
//  Created by Ezra Pease on 1/13/26.
//

import SwiftUI

struct JournalEditingScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var journalEntry: JournalEntry
    @State private var entryName = ""
    @State private var entryDescription = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Name") {
                        TextField("Entry Name", text: $entryName)
                    }
                    Section("Description") {
                        TextField("Entry Description", text: $entryDescription)
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                       save()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                entryName = journalEntry.name
                entryDescription = journalEntry.text
            }
        }
    }
    
    private func save() {
        journalEntry.name = entryName
        journalEntry.text = entryDescription
        dismiss()
    }
}

#Preview {
    JournalEditingScreen(journalEntry: JournalEntry())
}
