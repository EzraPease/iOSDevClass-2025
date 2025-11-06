//
//  ItemCellView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//


import SwiftUI

struct ItemCellView: View {
    let item: StoreItem

    var body: some View {
        HStack {
            if let image = item.artworkImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
