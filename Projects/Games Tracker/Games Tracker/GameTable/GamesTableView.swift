//
//  GamesTableView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI
import SwiftData



struct GamesTableView: View {
    @Query(sort: \Game.timeStamp, order: .reverse) var gamesList: [Game]
    
    @Environment(\.modelContext) private var context
    @State private var viewModel = GamesViewModel()
    
    
    var body: some View {
        NavigationStack {
            List {
//                if !gamesList.isEmpty {
                    ForEach(gamesList) { gameCell in
                        NavigationLink {
                            Text("Detail")
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
//                } else {
//                    HStack {
//                        Spacer()
//                        VStack {
//                            Text("No Games Yet")
//                            Text("Click + to create one")
//                        }
//                        .italic()
//                        Spacer()
//                    }
//                }
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
        .modelContainer(for: Game.self)
}
