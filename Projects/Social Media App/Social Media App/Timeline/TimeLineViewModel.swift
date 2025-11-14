//
//  TimeLineViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

@Observable
class TimeLineViewModel {
    var timeLinePosts: [PostViewModel] = [
        PostViewModel(
            title: "Title 1",
            description: "Description 1",
            likes: 683,
            comments: 121
        ),
        PostViewModel(
            image: URL(string: "https://picsum.photos/2000/2000"),
            title: "Title 2",
            description: "Description 2",
            likes: 58392,
            comments: 4321
        ),
        PostViewModel(
            image: URL(string: "https://picsum.photos/2000/2000"),
            title: "Title 3",
            description: "Description 3",
            likes: 4731,
            comments: 3340
        )
    ]
}
