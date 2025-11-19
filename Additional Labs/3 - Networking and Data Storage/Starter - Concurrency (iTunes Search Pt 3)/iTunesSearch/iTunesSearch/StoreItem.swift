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
    
    //    init(from decoder: any Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        collectionId = try? values.decodeIfPresent(Int.self, forKey: CodingKeys.collectionId)
    //        collectionName = try values.decode(String.self, forKey: CodingKeys.collectionName)
    //        artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
    //        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
    //        description = try? values.decode(String.self, forKey: CodingKeys.description)
    //    }
    
    enum CodingKeys: String, CodingKey {
        case collectionId = "collectionId"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case artworkURL = "artworkUrl60"
        case artistName = "artistName"
        case description = "description"
    }
}



struct SearchResponse: Codable {
    var results: [StoreItem]
}
