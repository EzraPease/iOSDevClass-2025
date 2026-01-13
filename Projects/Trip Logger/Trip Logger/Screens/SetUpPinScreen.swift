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
    @Environment(\.modelContext) private var context
    
    var dismissSheet: DismissAction
    @State var newTrip: Trip
    
    init(newTrip: Trip, dismissSheet: DismissAction) {
        self._newTrip = State(initialValue: newTrip)
        self.dismissSheet = dismissSheet
    }
    
    var body: some View {
            VStack {
                Text("Name your first pin, add photos, and add notes to this stop")
                    .font(.title2)
                    .fontWeight(.bold)
                Group {
                    TextField("Name", text: $newTrip.journalEntries.first!.name)
                    TextField("Description", text: $newTrip.journalEntries.first!.text)
                }
                .padding()
                .glassEffect()
                .padding(.horizontal)
                .shadow(radius: 10)
                PhotoScrollView(journalEntry: newTrip.journalEntries.first!)
                    .scrollIndicators(.hidden)
                    .padding()
                    .shadow(radius: 10)
            }
            .toolbar {
                Button("Save") {
                    saveTrip()
                }
            }
            .onAppear {
                print(newTrip.journalEntries.count)
            }
    }
    
    private func saveTrip() {
        do {
            context.insert(newTrip)
            try context.save()
            dismissSheet()
            print("Sheet Saved")
        } catch {
            print("Failed to save trip: \(error)")
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
