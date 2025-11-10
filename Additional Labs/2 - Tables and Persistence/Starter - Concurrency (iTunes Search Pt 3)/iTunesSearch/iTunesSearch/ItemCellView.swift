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
            if let url = item.artworkUrl60 {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
                Text(item.artistName)
                    .font(.headline)
                Text(item.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
