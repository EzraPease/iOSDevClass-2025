//
//  MediaType.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/13/25.
//


import SwiftUI

enum MediaType: String, CaseIterable {
    case music
    case movies = "movie"
    case apps = "software"
    case books = "ebook"
}
