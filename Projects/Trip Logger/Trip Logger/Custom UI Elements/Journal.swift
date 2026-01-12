//
//  Journal.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct Journal: View {
    @Binding var journalEntry: JournalEntry?
    var body: some View {
        JournalTopBar(journalEntry: $journalEntry)
            .padding()
        
        if let journalEntry {
            Text(journalEntry.date.formatted(date: .abbreviated, time: .omitted))
                .font(.headline)
            Text(journalEntry.text)
                .font(.body)
            
            PhotoScrollView(journalEntry: journalEntry)
        }
    }
}



struct JournalTopBar: View {
    @Binding var journalEntry: JournalEntry?
    
    var body: some View {
        HStack {
            Button("Edit") {
                // TODO: Add ability to edit journal entries
            }
            
            Spacer()
            
            Text(journalEntry?.name ?? "Journal")
                .font(.title)
            
            Spacer()
            
            Button("Dismiss") {
                journalEntry = nil
            }
        }
    }
}

#Preview("Journal View with Selected Entry from Mock Trip") {
    @Previewable @State var mockTrip = Trip.mock()
    
    TripMapScreen(trip: mockTrip, position: .automatic, selectedEntry: mockTrip.journalEntries.first)
}
