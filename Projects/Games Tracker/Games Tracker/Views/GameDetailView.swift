//
//  ScoreBoard.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/15/25.
//

import SwiftUI
import SwiftData



struct GameDetailView: View {
    @Environment(\.modelContext) private var context
    @State var game: Game
    @State private var viewModel = GameDetailViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(game.sortedPlayers) { player in
                    if let index = game.playerList.firstIndex(where: { $0.id == player.id }) {
                        PlayerRow(player: $game.playerList[index]) {
                            saveScores()
                        }
                    }
                }
                .onDelete(perform: deletePlayer)
                .padding(5)
            }
            .animation(.default, value: game.sortedPlayers.map(\.id))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(game.gameTitle)
                            .bold()
                        Divider()
                    }
                    .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addNewPlayer()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $viewModel.newPlayerPresented) {
                PlayersView(player: $game.playerList)
                    .presentationDetents([.height(300)])
            }
        }
    }
    
    /// Persist updated scores to SwiftData.
    private func saveScores() {
        do {
            try context.save()
        } catch {
            print("ERROR - UNABLE TO SAVE NEW SCORE \(error)")
        }
    }
    
    private func deletePlayer(at offsets: IndexSet) {
        // IndexSet is based on the sorted list, so translate to the underlying array.
        let playersToDelete = offsets.map { game.sortedPlayers[$0] }
        
        for player in playersToDelete {
            context.delete(player)
            
            if let index = game.playerList.firstIndex(where: { $0.id == player.id }) {
                game.playerList.remove(at: index)
            }
        }
    }
}



private struct PlayerRow: View {
    @Binding var player: Player
    var onScoreChanged: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: player.image)
                Text("\(player.name) ")
                    .padding(.horizontal, 4)
                    .bold()
                
                Spacer()
                
            }
            .padding(.horizontal, 3)
            Stepper(value: $player.score, in: 0...999) {
                Text("Score: \(player.score)")
                    .bold()
            }
            .onChange(of: player.score) { _, _ in
                onScoreChanged()
            }
        }
    }
}



#Preview {
    GameDetailView(game: Game(gameTitle: "Test Game",
                              playerSortBy: .highestScore,
                              winBy: .lowestScore,
                              playerList: [Player(name: "Player 1", score: 0),
                                           Player(name: "Player 2", score: 3)]))
    .modelContainer(for: Game.self)
}
