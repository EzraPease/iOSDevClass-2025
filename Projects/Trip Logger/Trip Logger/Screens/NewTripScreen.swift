//
//  NewTripView.swift
//  Trip Logger
//
//  Created by Jane Madsen on 4/29/25.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct NewTripScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var tripName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("First, give a name to your trip.")
                    .font(.title2)
                    .fontWeight(.bold)
                TextField("Type Here", text: $tripName)
            }
            .padding()
            .toolbar {
                NavigationLink("Next") {
                    PlacePinScreen(tripName: tripName, dismissSheet: dismiss)
                }
                .disabled(tripName.isEmpty)
            }
        }
    }
}

#Preview {
    NewTripScreen()
        .modelContainer(ModelContainer.preview)
}
