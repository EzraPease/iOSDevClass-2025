//
//  ContentView.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/16/25.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var trips: [Trip]
        
    @State var isShowingNewTrip = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ViewThatFits {
                if trips.isEmpty {
                    Text("No trips yet.")
                } else {
                    List {
                        ForEach(trips) { trip in
                            NavigationLink(
                                value: trip
                            ) {
                                Text(trip.name)
                            }
                        }
                    }
                    .navigationDestination(for: Trip.self) { trip in
                        TripMapScreen(
                            trip: trip,
                            position: .automatic,
                            navigationPath: $navigationPath
                        )
                    }
                }
            }
            .navigationTitle("Trip Logger")
            .toolbar {
                Button("Add") {
                    isShowingNewTrip = true
                }
            }
            .sheet(isPresented: $isShowingNewTrip) {
                NewTripScreen()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(ModelContainer.preview)
}
