//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//
import Foundation
import SwiftUI

struct SearchResponse: Codable {
    var results: [StoreItem]
}

// Example model for a table item
//struct StoreItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let artist: String
//    let artworkImage: URL?
//}

struct StoreItem: Codable, Identifiable {
    var id: String { String(collectionId) }
    var collectionId: Int
    
    let artworkUrl60: URL?
//    let kind: String
    let artistName: String
//    let trackName: String
    let description: String
}

enum CodingKeys: String, CodingKey {
    case artworkURL = "artworkUrl60"
    
//    enum AdditionalKeys: CodingKey {
//        case longDescription
//    }
}
