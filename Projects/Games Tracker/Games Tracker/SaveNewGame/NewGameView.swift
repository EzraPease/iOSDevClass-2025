//
//  NewGameView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI



struct NewGameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var gameName = ""
    @State private var sortMode: NewGameViewModel.PlayerSortMode = .highestScore
    @State private var winnerMode: NewGameViewModel.PlayerWinMode = .highestScore
    @State private var viewModel = NewGameViewModel()
    
    
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
                    
                    Picker("Who Wins?", selection: $winnerMode) {
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
                        
                    }
                }
            }
            .sheet(isPresented: $viewModel.newPlayerPresented) {
                PlayersView()
                    .presentationDetents([.height(300)])
            }
        }
    }
}


#Preview {
    NewGameView()
}
