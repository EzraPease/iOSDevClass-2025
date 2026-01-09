//
//  Cards.swift
//  DatePicker
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct Cards: Identifiable {
    var id = UUID()
    
    var description: String
    var date: Date
    var color: Color
    var photo: Image
}
