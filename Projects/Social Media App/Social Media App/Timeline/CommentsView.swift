//
//  CommentsView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/17/25.
//

import SwiftUI





struct CommentsView: View {
    let post: Post
    
    var body: some View {
        List {
//            Section(header: Text("Comments (\(post.numComments))").font(.headline)) {
//                ForEach(post.commentsList, id: \.self) { comment in
//                    Text(comment)
//                        .foregroundStyle(.secondary)
//                        .padding(.vertical, 6)
//                }
//                if post.commentsList.isEmpty {
//                    Text("No comments yet.")
//                        .foregroundStyle(.tertiary)
//                }
//            }
        }
    }
}


#Preview {
    CommentsView(post: Post(postID: UUID(), title: "Example Title", body: "Example Body", authorUserName: "Example Author Name", authorUserId: UUID(), likes: 124, userLiked: true, numComments: 582, createdDate: .init(timeIntervalSinceNow: -33000)))
}
