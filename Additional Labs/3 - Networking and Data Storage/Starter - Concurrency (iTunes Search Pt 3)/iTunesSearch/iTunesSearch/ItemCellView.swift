//
//  ItemCellView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//

import SwiftUI

struct ItemCellView: View {
    let name: String
    let artist: String

    var body: some View {
        HStack {

            Image(systemName: "photo")
                .resizable()
                .frame(width: 75, height: 75)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

//            if let previewUrl = item.previewUrl {
//                Button {
//
//                } label: {
//                    Image(systemName: "play.circle")
//                }
//            }
        }
        .padding(.vertical, 8)
    }
}
