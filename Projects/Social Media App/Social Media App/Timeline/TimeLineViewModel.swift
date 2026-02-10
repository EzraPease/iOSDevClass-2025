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
            timeLinePosts = try await apiController.fetchTimelinePosts()
        } catch {
            print("Error fetching timeline: \(error)")
        }
        print(timeLinePosts)
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
