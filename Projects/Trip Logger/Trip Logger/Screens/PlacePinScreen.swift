//
//  PlacePinScreen.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//


import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct PlacePinScreen: View {
    var tripName: String
    var dismissSheet: DismissAction
    @State private var newTrip: Trip
    
    init(tripName: String, dismissSheet: DismissAction) {
        self.tripName = tripName
        self.dismissSheet = dismissSheet
        _newTrip = State(initialValue: Trip(name: tripName))
    }
    
    var body: some View {
            VStack {
                MapReader { reader in // Allows conversion of a touch gesture into coordinates
                    Map {
                        // TODO: Display the pin the user placed
                        ForEach(newTrip.journalEntries) { entry in
                            Marker(item: entry.location.mapItem!)
                        }
                    }
                    .onTapGesture { location in
                        placePin(reader: reader, location: location)
                        print("New Pin Added")
                    }
                }
            }
            .navigationTitle("Place First Pin")
            .toolbar {
                NavigationLink("Next") {
                    SetUpPinScreen(newTrip: newTrip, dismissSheet: dismissSheet)
                }
            }

    }
    
    func placePin(reader: MapProxy, location: CGPoint) {
        if let coordinate = reader.convert(location, from: .local) {
            let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude, latitudeDelta: nil, longitudeDelta: nil)
            // TODO: Fill in the delta
            newTrip.journalEntries.append(JournalEntry(location: location))
        }
    }
}

#Preview {
    struct PlacePinScreenPreviewWrapper: View {
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            PlacePinScreen(tripName: "Example Trip Name", dismissSheet: dismiss)
        }
    }
    
    return NavigationStack {
        PlacePinScreenPreviewWrapper()
            .modelContainer(ModelContainer.preview)
    }
}
