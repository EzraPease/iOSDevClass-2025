//
//  MoviesView.swift
//  Lists and Forms Lab
//
//  Created by Ezra Pease on 10/7/25.
//

import SwiftUI


struct Movie: Identifiable {
    var id: String
    var movieHours: String
    var movieMinutes: String
    var releaseDate: String
}





struct MoviesView: View {
    
    @State private var movies: [Movie] = [
        Movie(id: "Harry Potter 1", movieHours: "2", movieMinutes: "32", releaseDate: "2001-11-16"),
        Movie(id: "Star Wars 4", movieHours: "2", movieMinutes: "10", releaseDate: "1977-05-25"),
        Movie(id: "Wizard of OZ", movieHours: "1", movieMinutes: "42", releaseDate: "1939-08-25"),
        Movie(id: "John Wick 1", movieHours: "1", movieMinutes: "41", releaseDate: "2014-10-24"),
        Movie(id: "Breaking Bad", movieHours: "0", movieMinutes: "58", releaseDate: "2008-01-20")
    ]
    
    var body: some View {
        List {
            Section {
                ForEach(movies) { movie in
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(movie.id)
                                .bold()
                            
                            Spacer()
                            
                            Text("Duration: \(movie.movieHours):\(movie.movieMinutes)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            
                        }
                        NavigationLink(destination: DetailedMoviesView()) {
                            
                        }
                        .padding(.horizontal)
                    }
                }
            } header: {
                Text("Movies")
            }
        }
    }
}

#Preview {
    MoviesView()
}
