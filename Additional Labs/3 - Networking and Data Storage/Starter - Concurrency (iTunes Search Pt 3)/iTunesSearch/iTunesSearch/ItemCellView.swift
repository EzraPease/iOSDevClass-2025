//
//  ItemCellView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//

import SwiftUI

struct ItemCellView: View {
    var storeItem: StoreItem
    var onPlayButtonPressed: () -> Void
    
    //    let name: String
    //    let artist: String
    
    var body: some View {
        HStack {
            if let artworkURL = storeItem.artworkURL {
                AsyncImage(url: artworkURL)
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
                if let trackName = storeItem.trackName {
                    Text(trackName)
                        .font(.headline)
                } else {
                    Text("Failed to load name...")
                }
                Text(storeItem.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
                        if let previewURL = storeItem.previewURL {
                            Button {
                                
                            } label: {
                                Image(systemName: "play.circle")
                            }
                        }
        }
        .padding(.vertical, 8)
    }
}
