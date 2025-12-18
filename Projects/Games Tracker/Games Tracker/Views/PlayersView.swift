//
//  PlayersView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/12/25.
//

import SwiftUI



struct PlayersView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var player: [Player]
    
    @State private var playerName = ""
    @State private var playerScore = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Player Name", text: $playerName)
                }
                Section {
//                    TextField("Score (Optional)", text: $playerScore)
                    Stepper("Score (Optional): \(playerScore)", value: $playerScore, in: 0...999)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Player") {
                        savePlayer()
                    }
                }
            }
        }
    }
    
    private func savePlayer() {
            let newPlayer = Player(
                name: playerName,
                score: playerScore
            )
        player.append(newPlayer)
        dismiss()
    }
}


//#Preview {
//    PlayersView()
//}
