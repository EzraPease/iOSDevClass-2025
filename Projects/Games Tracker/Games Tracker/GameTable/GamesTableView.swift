//
//  GamesTableView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI
import SwiftData



struct GamesTableView: View {
    @Environment(\.modelContext) private var context
    @State private var gamesModel: [GamesModel]? = [
        GamesModel(gameTitle: "Hearts", currentLeader: "Player 2"),
        GamesModel(gameTitle: "Golf", currentLeader: "Player 6"),
        GamesModel(gameTitle: "Wii Sports", currentLeader: "Player 1"),
        GamesModel(gameTitle: "Mario Kart", currentLeader: "Player 4")
        ]
    @State private var viewModel = GamesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if let gamesModel {
                    ForEach(gamesModel) { gameCell in
                        NavigationLink {
                            
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: gameCell.image)
                                    Text(gameCell.gameTitle)
                                }
                                Text("Current Leader: \(gameCell.currentLeader)")
                            }
                            .padding()
                        }
                    }
                } else {
                    Text("No available data")
                }
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: viewModel.addGame) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.addPlayerPresented) {
                NewGameView()
            }
        }
    }
}




#Preview {
    GamesTableView()
        .modelContainer(for: GamesModel.self)
}
