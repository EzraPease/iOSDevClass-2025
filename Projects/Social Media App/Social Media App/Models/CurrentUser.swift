//
//  UserProfileViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

// Currently Logged in User
struct CurrentUser: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var userUUID: UUID
    var bio: String?
    var techInterests: String?
    var posts: [Post] = []
    
    // you'll need to make this codable so that you can get the data from the json endpoint
}
