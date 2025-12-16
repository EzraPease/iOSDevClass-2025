//
//  NewGameView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI
import SwiftData



struct NewGameView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var gameName = ""
    @State private var sortMode: NewGameViewModel.PlayerSortMode = .highestScore
    @State private var winMode: NewGameViewModel.PlayerWinMode = .highestScore
    @State private var playerList: [Player] = []
    @State private var viewModel = NewGameViewModel()
//    @State private var game = Game()
    
//    var newGame: [NewGameModel] {
//        return games.newGame
//    }
//    var games: GamesModel
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading) {
                    Text("Sort Players By:")
                        .font(.headline)
                    
                    Picker("Sort Players By:", selection: $sortMode) {
                        Text("Highest Score").tag(NewGameViewModel.PlayerSortMode.highestScore)
                        Text("Lowest Score").tag(NewGameViewModel.PlayerSortMode.lowestScore)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
                VStack(alignment: .leading) {
                    Text("Who Wins?")
                        .font(.headline)
                    
                    Picker("Who Wins?", selection: $winMode) {
                        Text("Highest Score").tag(NewGameViewModel.PlayerWinMode.highestScore)
                        Text("Lowest Score").tag(NewGameViewModel.PlayerWinMode.lowestScore)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
                .padding(.vertical)
                
                TextField("Game Name", text: $gameName)
                    .padding()
                    .glassEffect()
                
                HStack {
                    Spacer()
                    
                    Text("Players")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                ZStack {
                    List {
                        ForEach(playerList) { player in
                            Text(player.name)
                        }
                    }
                    VStack {
                        Spacer()
                        
                        Button("Add Player") {
                            viewModel.newPlayerPresented = true
                        }
                        .padding()
                        .glassEffect()
                    }
                }
            }
            .padding()
            .navigationTitle("New Game")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveGame()
                    }
                }
            }
            .sheet(isPresented: $viewModel.newPlayerPresented) {
                PlayersView(player: $playerList)
                    .presentationDetents([.height(300)])
            }
        }
    }
    
    private func saveGame() {
//        let newGame = NewGameModel(sortBy: sortMode,
//                                   winBy: winMode,
//                              playerList: playerList)
        let newGame = Game(
            gameTitle: gameName,
            playerSortBy: sortMode,
            winBy: winMode,
            playerList: playerList
        )
        print(newGame) // Debuging
        
        context.insert(newGame)
        do {
            try context.save()
            dismiss()
        } catch {
            print("Unable to save game: \(error)")
        }
    }
}



#Preview {
    NewGameView()
        .modelContainer(for: Game.self)
}
