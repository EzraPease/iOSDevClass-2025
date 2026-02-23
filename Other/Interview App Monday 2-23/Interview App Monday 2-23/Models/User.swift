//
//  Users.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id = UUID()
    
    var username: String
    var selected: Bool = false
    var orderIndex: Int = 0
    
    init(username: String, orderIndex: Int) {
        self.username = username
        self.orderIndex = orderIndex
    }
}
