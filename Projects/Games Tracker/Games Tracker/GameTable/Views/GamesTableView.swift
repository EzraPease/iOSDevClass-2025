//
//  GamesTableView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI
import SwiftData



struct GamesTableView: View {
    @Query(sort: \Game.timeStamp, order: .forward) var gamesList: [Game]
    
    @Environment(\.modelContext) private var context
    @State private var viewModel = GamesViewModel()
    
    
    var body: some View {
        NavigationStack {
            List {
                if !gamesList.isEmpty {
                    ForEach(gamesList) { game in
                        NavigationLink {
                            GameDetailView(game: game)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: game.image)
                                    Text(game.gameTitle)
                                }
                                if let currentLeader = game.currentLeader {
                                    Text("Current Leader: \(currentLeader)")
                                }
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteGame)
                } else {
                    HStack {
                        Spacer()
                        VStack {
                            Text("No Games Yet")
                            Text("Click + to create one")
                        }
                        .italic()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: viewModel.showAddGameView) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.addPlayerPresented) {
                NewGameView()
            }
        }
    }
    
    private func deleteGame(at offsets: IndexSet) {
        for index in offsets {
            context.delete(gamesList[index])
        }
    }
}




#Preview {
    GamesTableView()
        .modelContainer(for: Game.self)
}
