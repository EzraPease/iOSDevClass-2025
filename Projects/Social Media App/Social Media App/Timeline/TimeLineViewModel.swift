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
        timeLinePosts = []
    }
    
    func fetchCurrentUserPosts() async {
//        let posts = UserAPIRequest(postService: MockPostService())
//        for post in posts.userPosts {
//            timeLinePosts.append(post)
//        }
    }
}
