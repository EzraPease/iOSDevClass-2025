//
//  UserProfileViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

// Currently Logged in User
struct CurrentUser: Codable {
    var profilePhoto: URL?
    var backgroundCoverPhoto: URL?
    
    var firstName: String
    var lastName: String
    var userBio: String
    var techInterests: String
    
    // you'll need to make this codable so that you can get the data from the json endpoint
}
