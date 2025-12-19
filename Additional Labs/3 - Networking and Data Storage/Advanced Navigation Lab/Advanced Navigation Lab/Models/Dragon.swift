//
//  Dragon.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI



struct Dragon: Identifiable, Hashable {
    var id = UUID()
    
    var image: String
    var lore: String
    var age: Int
    var fireType: String
    var abilities: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Dragon, rhs: Dragon) -> Bool {
        lhs.id == rhs.id
    }
}
