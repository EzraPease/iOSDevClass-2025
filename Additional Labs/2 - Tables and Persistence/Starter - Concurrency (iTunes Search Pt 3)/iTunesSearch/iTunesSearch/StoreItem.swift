//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//
import Foundation
import SwiftUI

// Example model for a table item
struct StoreItem: Identifiable, Codable {
//    let artworkImage: UIImage?
    
    // Some extra (Unessesary Values)
//    let collectionPrice: Double
//    let wrapperType: String
//    let country: String
//    let isStreamable: Bool
//    let releaseDate: String
//    let artistId: Int
//    let collectionViewUrl: String
    
    let id = UUID()
    let name: String
    let artist: String
    
    let artworkUrl60: URL?
    let kind: String
    let artistName: String
    let trackName: String
    let description: String
}
