//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Ezra Pease on 11/14/25.
//

import SwiftUI

struct StoreItem: Codable, Identifiable, Hashable {
    var id: String { String(collectionId) }
    var collectionId: Int
    
    let artworkURL: URL?
//    let kind: String
    let artistName: String
//    let trackName: String
    let description: String
    
    init(from decoder: any Decoder) throws {
        
    }
    
    enum CodingKeys: String, CodingKey {
        case artworkURL = "artworkUrl60"
        
        //    enum AdditionalKeys: CodingKey {
        //        case longDescription
        //    }
    }
}



struct SearchResponse: Codable {
    var results: [StoreItem]
}
