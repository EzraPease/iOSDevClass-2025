//
//  ContentView.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/2/25.
//

import SwiftUI
import SwiftData


struct EntriesView: View {
    @Query(sort: \JournalEntries.timeStamp, order: .reverse) private var journalEntries: [JournalEntries]
    
    @Environment(\.modelContext) private var context
    @State private var detailViewPresented: JournalEntries?
    @State private var newEntryPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                if journalEntries.isEmpty {
                    DefaultEmptyView()
                } else {
                    ForEach(journalEntries) { entry in
                        Button {
                            detailViewPresented = entry
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(entry.title)
                                        .font(.title2)
                                        .bold()
                                    Text(entry.body)
                                }
                                Spacer()
                                
                                Text("\(entry.timeStamp.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .italic()
                                    .opacity(0.6)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Journal Entries")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: newEntry) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $detailViewPresented) { entry in
                    EntryDetailView(entry: entry)
            }
            .sheet(isPresented: $newEntryPresented) {
                NewEntryView()
            }
        }
    }
    private func DefaultEmptyView() -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                HStack {
                    Text("No entries yet")
                    Image(systemName: "book")
                }
                .bold()
                Text("Tap + to make your first entry!")
            }
            Spacer()
        }
    }
    
    private func save(title: String, body: String) {
        let newEntry = JournalEntries(title: title, body: body)
        context.insert(newEntry)
    }
    
    private func newEntry() {
        newEntryPresented = true
    }
}


#Preview {
    EntriesView()
        .modelContainer(for: JournalEntries.self)
}
