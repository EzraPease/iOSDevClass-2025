//
//  EditTripScreen.swift
//  Trip Logger
//
//  Created by Ezra Pease on 1/13/26.
//

import SwiftUI

struct EditTripScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State var trip: Trip
    @State private var editedTripName = ""
    @State private var showingDeleteConfirmation = false
    var onDelete: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            TextField("Trip Name", text: $editedTripName)
                .padding()
                .glassEffect()
                .padding()
                .shadow(radius: 10)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveTripName()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Delete") {
                    showingDeleteConfirmation = true
                }
            }
        }
        }
        .onAppear {
            editedTripName = trip.name
        }
        .alert("Delete Trip?", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                deleteTrip()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will permanently remove this trip and its data.")
        }
    }
    
    private func saveTripName() {
        trip.name = editedTripName
        dismiss()
    }
    
    private func deleteTrip() {
        context.delete(trip)
        dismiss()
        onDelete?()
    }
}

#Preview {
    EditTripScreen(trip: Trip(name: "Example Trip"), onDelete: nil)
}
