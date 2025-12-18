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
                    .onMove(perform: moveGames)
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
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $viewModel.addPlayerPresented) {
                NewGameView()
            }
        }
    }
    
    private func moveGames(from source: IndexSet, to destination: Int) {
        // Create a temporary array reflecting the current order
        var ordered = gamesList
        // Apply the move to the temporary array
        ordered.move(fromOffsets: source, toOffset: destination)

        // Reassign timestamps in ascending order to persist the new order
        // Use a base date and increasing intervals to ensure strict ordering
        let baseDate = Date()
        for (index, game) in ordered.enumerated() {
            // Space timestamps by one second to maintain order stability
            game.timeStamp = baseDate.addingTimeInterval(TimeInterval(index))
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
