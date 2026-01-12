//
//  SetUpPinScreen.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct SetUpPinScreen: View {
    var dismissSheet: DismissAction
    @State var newTrip: Trip
    
    init(newTrip: Trip, dismissSheet: DismissAction) {
        self._newTrip = State(initialValue: newTrip)
        self.dismissSheet = dismissSheet
    }
    
    var body: some View {
            VStack {
                Text("Name your first pin, add photos, and add notes to this stop")
                TextField("Entry Name", text: $newTrip.journalEntries.first!.name)
                TextField("Entry Text", text: $newTrip.journalEntries.first!.text)
                PhotoScrollView(journalEntry: newTrip.journalEntries.first!)
            }
            .toolbar {
                Button("Save") {
                    dismissSheet()
                }
            }
    }
}

#Preview {
    struct SetUpPinScreenPreviewWrapper: View {
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            let exampleTrip: Trip = {
                let trip = Trip(name: "Example Trip")
                trip.journalEntries.append(JournalEntry(name: "", date: .now, text: ""))
                return trip
            }()
            return SetUpPinScreen(newTrip: exampleTrip, dismissSheet: dismiss)
        }
    }
    
    return NavigationStack {
        SetUpPinScreenPreviewWrapper()
    }
}
