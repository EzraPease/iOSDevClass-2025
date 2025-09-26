//
//  ContentView.swift
//  VStack HStack Lab
//
//  Created by Ezra Pease on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 50))
                    .foregroundStyle(.gray)
                VStack(alignment: .leading) {
                    Text("Geoff Jefferson")
                        .bold()
                    Text("GeoffTheBozo@gmail.com")
                }
                Spacer()
            }
            HStack(alignment: .top) {   // Awards / Followers / Likes
                Spacer(minLength: 10)
                VStack {
                    Image(systemName: "trophy")
                    Text("Awards")
                        .bold()
                        .font(.title3)
                    Text("Congressional Medal Of Honor")
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Image(systemName: "person.3")
                    Text("Followers")
                        .bold()
                        .font(.title3)
                    Text("25,000,000")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Image(systemName: "heart")
                    Text("Likes")
                        .bold()
                        .font(.title3)
                    Text("19.7M")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                Spacer(minLength: 10)
            }
            .frame(height: 90)
            .background(.blue.opacity(0.5), in: Capsule())
            HStack(alignment: .top) {   // Connections / Places Visted
                
                let connections: [String] = ["Henry", "Jimouthy", "Ted", "Geoff Bozos"]
                Spacer()
                VStack {
                    Text("Connections")
                        .font(.title2)
                        .bold()
                        .underline()
                    ForEach (connections, id: \.self) { people in
                        Text(people)
                    }
                }
                
                let placesVisted: [String] = ["Orem", "Monterey", "Salt Lake", "Japan"]
                
                VStack {
                    Text("Places Visited")
                        .font(.title2)
                        .bold()
                        .underline()
                    ForEach (placesVisted, id: \.self) { places in
                        Text(places)
                    }
                }
                Spacer()
            }
            .frame(minHeight: 150)
            .background(.teal.opacity(0.75), in: Capsule())
            Spacer()
            HStack {    // "My Dog"
                let dogs: [String] = ["Moose", "Lola", "Charles"]
                ForEach (dogs, id: \.self) { doggo in
                    ZStack(alignment: .bottomLeading) {
                        Image(systemName: "dog")
                            .resizable()
                            .scaledToFit()
                        Text("My Dog \(doggo)")
                            .background(.black.opacity(0.75))
                            .foregroundStyle(.white)
                            
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
