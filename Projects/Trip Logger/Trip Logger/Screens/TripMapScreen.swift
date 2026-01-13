//
//  TripMapScreen.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct TripMapScreen: View {
    var trip: Trip
    
    @State var position: MapCameraPosition
    @State var selectedEntry: JournalEntry?
    @State private var editTripIsPresented = false
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            MapReader { reader in
                Map(position: $position, selection: $selectedEntry) {
                    ForEach(trip.journalEntries) { journalEntry in
                        // Creates a pin on the map for every journal entry using its stored name and coordinates
                        Marker("\(journalEntry.name)", coordinate: journalEntry.location.coordinate!)
                            .tag(journalEntry) // Allows the journal entry to be selected and stored in selectedEntry
                    }
                }
                .onTapGesture { location in
                    placePin(reader: reader, location: location)
                    print("New Pin Added")
                }
            }
            
            if selectedEntry != nil {
                // Show Journal bar with name, date, notes, and photos
                Journal(journalEntry: $selectedEntry)
            }
            
        }
        .navigationTitle(trip.name)
        .toolbar {
            Button("Edit") {
                // TODO: Add ability to edit trip name, delete trip
                editTripIsPresented = true
            }
        }
        .sheet(isPresented: $editTripIsPresented) {
            EditTripScreen(
                trip: trip,
                onDelete: {
                    editTripIsPresented = false
                    // Pop the navigation stack after a short delay to allow sheet dismissal
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        navigationPath.removeLast()
                    }
                }
            )
            .presentationDetents([.fraction(0.35)])
        }
    }
    
    func placePin(reader: MapProxy, location: CGPoint) {
        if let coordinate = reader.convert(location, from: .local) {
            let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude, latitudeDelta: nil, longitudeDelta: nil)
            // TODO: Fill in the delta
            trip.journalEntries.append(JournalEntry(location: location))
        }
    }
}

#Preview {
    NavigationStack {
        TripMapScreen(trip: Trip.mock(), position: .automatic, navigationPath: .constant(NavigationPath()))
    }
}
