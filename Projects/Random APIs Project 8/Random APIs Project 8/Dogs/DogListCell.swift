//
//  DogListCell.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI

struct DogListCell: Hashable, Identifiable {
    var id = UUID()
    var image: URL
    var name: String
}



