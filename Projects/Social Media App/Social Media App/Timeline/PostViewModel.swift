//
//  Untitled.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

struct PostViewModel: Codable {
//    var user: 
    var image: URL?
    var title: String
    var description: String
    
    var likes: Int
    var comments: Int
    
    var commentsList: [String] = []
}

