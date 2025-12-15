//
//  PlayersView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/12/25.
//

import SwiftUI



struct PlayersView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var playerName = ""
    @State private var playerScore = ""
    @State private var 
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Player Name", text: $playerName)
                }
                Section {
                    TextField("Score (Optional)", text: $playerScore)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
//                        playerName = ""
//                        playerScore = ""
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Player") {
                        
                    }
                }
            }
        }
    }
    
    private func save() {
        
    }
}


#Preview {
    PlayersView()
}
