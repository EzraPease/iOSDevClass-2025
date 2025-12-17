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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($game.playerList) { $player in
                    HStack {
                        Text("\(player.name) ")
                            .padding(.horizontal, 4)
                        
                        Spacer()
                        
                        Stepper(value: $player.score, in: 0...999) {
                            Text("\(player.score)")
                        }
                        .onChange(of: player.score) { _, _ in
                            try? context.save()
                            print("Current score updated to: \(player.score)")
                        }
                    }
                    .padding(.horizontal, 3)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Leaderboard")
                            .font(.largeTitle)
                            .bold()
                        Text(game.gameTitle)
                            .italic()
                    }
                    .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                         
                    } label: {
                        Image(systemName: "plus")
                    }
                }
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
