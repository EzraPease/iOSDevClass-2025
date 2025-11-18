//
//  CurrentUserViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

@Observable
class CurrentUserViewModel {
    // Temporary Current User
    var currentUser: CurrentUser?
    var recentPost: PostViewModel?
    
    var userPosts: [PostViewModel] = [
        PostViewModel(image: URL(string: "https://picsum.photos/2000/2000"),
                                   title: "Post Title 1",
                                   description: "Post Description 1",
                                   likes: 320,
                                   comments: 137),
        PostViewModel(image: URL(string: "https://picsum.photos/2000/2000"),
                                   title: "Post Title 2",
                                   description: "Post Description 2",
                                   likes: 198,
                                   comments: 19),
        PostViewModel(image: URL(string: "https://picsum.photos/2000/2000"),
                                   title: "Post Title 3",
                                   description: "Post Description 3",
                                   likes: 47491,
                                   comments: 1347),
        PostViewModel(image: URL(string: "https://picsum.photos/2000/2000"),
                                   title: "Post Title 4",
                                   description: "Post Description 4",
                                   likes: 581,
                                   comments: 433),
        PostViewModel(image: URL(string: "https://picsum.photos/2000/2000"),
                                   title: "Post Title 5",
                                   description: "Post Description 5",
                                   likes: 3240,
                                   comments: 2413)
    ]
    
    
    // have the state to display, like this current user (point up)
    
    // make a function that fetches the data that you want to display. Then set the variable
    
    func fetchCurrentUser() async {
        // this is where the network call will go.
        // if you want to simulate this
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        currentUser = CurrentUser(profilePhoto: URL(string: "https://hws.dev/paul.jpg"),
                                  backgroundCoverPhoto: URL(string: "https://picsum.photos/400/200"),
                                  firstName: "Ezra",
                                  lastName: "Pease",
                                  userBio: "Insert user bio here",
                                  techInterests: "I really like computers, computer good yes")
        
        if !userPosts.isEmpty {
            recentPost = userPosts.last
        }
    }
}





