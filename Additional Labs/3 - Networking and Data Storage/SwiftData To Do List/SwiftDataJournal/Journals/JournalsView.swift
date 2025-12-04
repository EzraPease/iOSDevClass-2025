//
//  JournalsView.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/4/25.
//

import SwiftUI
import SwiftData


struct JournalsView: View {
    @Query(sort: \Journals.timeStamp, order: .reverse) private var journals: [Journals]
    
    @Environment(\.modelContext) private var context
    @State private var entriesViewPresented: Journals?
    @State private var newJournalPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                if journals.isEmpty {
                    DefaultEmptyView()
                } else {
                    ForEach(journals) { journal in
                        NavigationLink {
                            EntriesView(journal: journal)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(journal.title)
                                        .font(.title2)
                                        .bold()
                                    Text(journal.body)
                                }
                                Spacer()
                                
                                Text("\(journal.timeStamp.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .italic()
                                    .opacity(0.6)
                            }
                        }
                    }
                    .onDelete(perform: deleteJournal)
                }
            }
            .navigationTitle("Journals")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: newEntry) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $newJournalPresented) {
                NewJournalView()
            }
        }
    }
    private func DefaultEmptyView() -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                HStack {
                    Text("No Journals yet")
                    Image(systemName: "book")
                }
                .bold()
                Text("Tap + to make your first Journal!")
            }
            Spacer()
        }
    }
    
    private func deleteJournal(at offsets: IndexSet) {
        for index in offsets {
            context.delete(journals[index])
        }
    }
    
    private func save(title: String, body: String) {
        let newEntry = Journals(title: title, body: body)
        context.insert(newEntry)
    }
    
    private func newEntry() {
        newJournalPresented = true
    }
}



#Preview {
    JournalsView()
        .modelContainer(for: Journals.self)
}
