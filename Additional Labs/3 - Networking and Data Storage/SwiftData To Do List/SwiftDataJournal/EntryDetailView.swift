//
//  EntryDetailView.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/2/25.
//

import SwiftUI
import SwiftData

struct EntryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Bindable var entry: JournalEntries
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Title", text: $entry.title)
                }
                Section {
                    TextField("Body", text: $entry.body, axis: .vertical)
                        .lineLimit(3...10)
                }
            }
            .navigationTitle("Entry Details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") { dismiss() }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Delete", role: .destructive) {
                        context.delete(entry)
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }

        }
    }
}
