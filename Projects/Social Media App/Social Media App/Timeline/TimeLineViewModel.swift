//
//  TimeLineViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI
import Observation

@Observable
class TimeLineViewModel {
    var timeLinePosts: [Post] = []
    private let apiController: UserAPIRequest
    
    init(apiController: UserAPIRequest) {
        self.apiController = apiController
    }
    
    func fetchTimeLine() async {
        do {
            let posts = try await apiController.fetchTimelinePosts()
            await MainActor.run {
                self.timeLinePosts = posts
            }
        } catch {
            print("Error fetching timeline: \(error)")
        }
    }
    
    func fetchCurrentUserPosts() async {
//        let posts = UserAPIRequest(postService: MockPostService())
//        for post in posts.userPosts {
//            timeLinePosts.append(post)
//        }
    }

    func delete(post: Post) async {
        do {
            try await apiController.deletePost(postID: post.postID)
            await fetchTimeLine()
        } catch {
            print("Error deleting post: \(error)")
        }
    }
}
