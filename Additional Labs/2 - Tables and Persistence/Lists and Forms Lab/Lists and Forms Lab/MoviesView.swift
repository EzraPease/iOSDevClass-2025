//
//  MoviesView.swift
//  Lists and Forms Lab
//
//  Created by Ezra Pease on 10/7/25.
//

import SwiftUI


struct Movie: Identifiable {
    var id: UUID = UUID()
    var name: String
    var movieHours: String
    var movieMinutes: String
    var releaseDate: String
}





struct MoviesView: View {
    
    @State private var movies: [Movie] = [
        Movie(name: "Harry Potter 1", movieHours: "2", movieMinutes: "32", releaseDate: "2001-11-16"),
        Movie(name: "Star Wars 4", movieHours: "2", movieMinutes: "10", releaseDate: "1977-05-25"),
        Movie(name: "Wizard of OZ", movieHours: "1", movieMinutes: "42", releaseDate: "1939-08-25"),
        Movie(name: "John Wick 1", movieHours: "1", movieMinutes: "41", releaseDate: "2014-10-24"),
        Movie(name: "Breaking Bad", movieHours: "0", movieMinutes: "58", releaseDate: "2008-01-20")
    ]
    
    var body: some View {
        NavigationStack {
            VStack{
                List($movies) { $movie in
                    NavigationLink {
                        DetailedMoviesView(movie: $movie)
                    } label: {
                        Text(movie.name)
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MoviesView()
}
