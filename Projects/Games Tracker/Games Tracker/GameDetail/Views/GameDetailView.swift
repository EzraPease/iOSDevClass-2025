//
//  ScoreBoard.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/15/25.
//

import SwiftUI



struct GameDetailView: View {
    @State var game: Game
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(game.playerList) { player in
                    HStack {
                        Text(player.name)
                        
                        Spacer()
                        
                        Text("\(player.score)")
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
}
