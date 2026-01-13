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
                .scrollIndicators(.hidden)
                .padding()
                .shadow(radius: 10)
        }
    }
}



struct JournalTopBar: View {
    @Binding var journalEntry: JournalEntry?
    
    @State private var editingModePresented = false
    
    var body: some View {
        HStack {
            Button("Edit") {
                // TODO: Add ability to edit journal entries
                editingModePresented = true
                print("Editing Mode Enabled")
            }
            
            Spacer()
            
            Text(journalEntry?.name ?? "Journal")
                .font(.title)
            
            Spacer()
            
            Button("Dismiss") {
                journalEntry = nil
            }
        }
        .sheet(isPresented: $editingModePresented) {
            if let journalEntry {
                JournalEditingScreen(journalEntry: journalEntry)
                    .presentationDetents([.fraction(0.4)])
            }
        }
    }
}

#Preview {
    @Previewable @State var mockTrip = Trip.mock()
    @State var path = NavigationPath()
    
    TripMapScreen(
        trip: mockTrip,
        position: .automatic,
        selectedEntry: mockTrip.journalEntries.first,
        navigationPath: $path
    )
}
