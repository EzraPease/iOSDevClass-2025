//
//  TimeLineViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

@Observable
class TimeLineViewModel {
    var timeLinePosts: [Post] = []
    
    
    func fetchTimeLine() async {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        timeLinePosts = [
            PostViewModel(
                title: "Timeline Post 1",
                description: "Description 1",
                likes: 683,
                comments: 121,
                commentsList: [
                    "Comment 1",
                    "Love this!",
                    "So inspiring 🔥",
                    "Congrats!",
                    "Can you share more details?",
                    "Following for updates"
                ]
            ),
            PostViewModel(
                image: URL(string: "https://picsum.photos/2000/2000"),
                title: "Timeline Post 2",
                description: "Description 2",
                likes: 58392,
                comments: 4321,
                commentsList: [
                    "Comment 2",
                    "This photo is amazing",
                    "What camera did you use?",
                    "Instant wallpaper 😍",
                    "Colors are popping!",
                    "Saved for later"
                ]
            ),
            PostViewModel(
                image: URL(string: "https://picsum.photos/2000/2000"),
                title: "Timeline Post 3",
                description: "Description 3",
                likes: 4731,
                comments: 3340,
                commentsList: [
                    "Comment 3",
                    "Great write-up",
                    "Super helpful, thanks",
                    "I learned something new today",
                    "Any tips for beginners?",
                    "Sharing with my team"
                ]
            )
        ]
    }
    
    func fetchCurrentUserPosts() async {
        let posts = CurrentUserViewModel(postService: MockPostService())
        for post in posts.userPosts {
            timeLinePosts.append(post)
        }
    }
}
