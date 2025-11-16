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
}

struct LikesAndComments: View {
    // Re-usable view to for Likes and Comments in UserProfile and TimeLineView
    var body: some View {
        
    }
}

