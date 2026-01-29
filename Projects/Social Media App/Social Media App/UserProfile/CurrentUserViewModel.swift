//
//  CurrentUserViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

protocol UserAPICall {
    func fetchCurrentUser() async
}

@Observable
class CurrentUserViewModel: UserAPICall {
    var currentUser: CurrentUser?
    var recentPost: Post?
    var userPosts: [Post]
    var userLoggedIn = false
    
    init(currentUser: CurrentUser? = nil, recentPost: Post? = nil, userPosts: [Post] = []) {
        self.currentUser = currentUser
        self.recentPost = recentPost
        self.userPosts = userPosts
    }
    
    // have the state to display, like this current user (point up)
    
    // make a function that fetches the data that you want to display. Then set the variable
    
    func fetchCurrentUser() async {
        // this is where the network call will go.
        // if you want to simulate this
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        currentUser = CurrentUser(firstName: "Ezra",
                                  lastName: "Pease",
                                  userName: "Ezra Pease",
                                  userUUID: UUID(),
                                  bio: "Insert user bio here",
                                  techInterests: "I really like computers, computer good yes")
        
        if !userPosts.isEmpty {
            recentPost = userPosts.last
        }
    }
}





