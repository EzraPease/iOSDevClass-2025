//
//  ContentView.swift
//  Lists and Forms Lab
//
//  Created by Ezra Pease on 10/7/25.
//

import SwiftUI

struct DetailedMoviesView: View {
    
    @Binding var movie: Movie
    
    var body: some View {
        VStack {
            Form {
                Section("Title") {
                    TextField("Movie Name", text: $movie.name)
                }
                
                Section("Duration") {
                    TextField("Hours", text: $movie.movieHours)
                        .keyboardType(.numberPad)
                    
                    TextField("Minutes", text: $movie.movieMinutes)
                        .keyboardType(.numberPad)
                }
                
                Section("Release Date - (YYYY-MM-DD)") {
                    TextField("Release Date", text: $movie.releaseDate)
                }
            }
        }
    }
}

