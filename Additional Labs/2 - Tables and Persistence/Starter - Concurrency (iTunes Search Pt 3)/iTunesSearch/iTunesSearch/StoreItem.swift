//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//
import Foundation
import SwiftUI

// Example model for a table item
struct StoreItem: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let artworkImage: UIImage?
}
