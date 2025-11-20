//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Ezra Pease on 11/14/25.
//

import SwiftUI

struct StoreItem: Codable, Identifiable, Hashable {
    var id = UUID()
    var collectionId: Int?
    var collectionName: String?
    let trackName: String?
    
    let artworkURL: URL?
    let artistName: String
    let description: String?
    let previewURL: URL?
    
    
    enum CodingKeys: String, CodingKey {
        case collectionId = "collectionId"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case artworkURL = "artworkUrl60"
        case artistName = "artistName"
        case description = "description"
        case previewURL = "previewUrl"
    }
}



struct SearchResponse: Codable {
    var results: [StoreItem]
}
