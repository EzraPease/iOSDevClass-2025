//
//  CommentsView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/17/25.
//

import SwiftUI





struct CommentsView: View {
    let post: PostViewModel
    
    var body: some View {
        List {
            Section(header: Text("Comments (\(post.commentsList.count))").font(.headline)) {
                ForEach(post.commentsList, id: \.self) { comment in
                    Text(comment)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 6)
                }
                if post.commentsList.isEmpty {
                    Text("No comments yet.")
                        .foregroundStyle(.tertiary)
                }
            }
        }
    }
}


#Preview {
    CommentsView(post: PostViewModel(
        title: "Title 1",
        description: "Description 1",
        likes: 683,
        comments: 121,
        commentsList: [
            "Love this!",
            "So inspiring 🔥",
            "Congrats!",
            "Can you share more details?",
            "Following for updates"
        ]
    ))
}
