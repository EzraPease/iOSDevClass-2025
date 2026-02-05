//
//  CurrentUserView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/18/25.
//

import SwiftUI

struct CurrentUserView: View {
    @Environment(UserAPIRequest.self) private var apiController
    @State private var editingPost: Post? = nil
    @State private var isEditingPresented: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.backgroundWhite, .backgroundWhite, .gray],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                ZStack {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.gray)
                }
                ScrollView { // Displays user data and user posts
                    if let currentUser = apiController.currentUser {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                HStack { // Name
                                    Text(currentUser.firstName)
                                    Text(currentUser.lastName)
                                }
                                .font(.title)
                                .bold()
                                
                                if let userBio = currentUser.bio {
                                    Text(userBio) // User Bio
                                        .italic()
                                        .font(.footnote)
                                }
                            }
                            .padding(.vertical, 40)
                            
                            if let techInterests = currentUser.techInterests {
                                Text(techInterests) // User Tech Interests
                                    .padding(.vertical)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                        
                        if !currentUser.posts.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Your Posts")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ForEach(currentUser.posts, id: \.postID) { post in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(post.title)
                                            .font(.headline)
                                        Text(post.body)
                                        HStack {
                                            HStack {
                                                Text("\(post.likes)")
                                                Image(systemName: "hand.thumbsup")
                                            }
                                            Spacer()
                                            HStack {
                                                Text("\(post.numComments)")
                                                Image(systemName: "message")
                                            }
                                        }
                                        .font(.subheadline)
                                        
                                        HStack {
                                            Text(post.createdDate.formatted(date: .abbreviated, time: .shortened))
                                        }
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                    .padding()
                                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                                    .contextMenu {
                                        Button {
                                            editingPost = post
                                            isEditingPresented = true
                                        } label: {
                                            Label("Edit Post", systemImage: "pencil")
                                        }
                                        Button(role: .destructive) {
                                            Task {
                                                await delete(post: post)
                                            }
                                        } label: {
                                            Label("Delete Post", systemImage: "trash")
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    } else {
                        // Loading indicator
                        ProgressView()
                    }
                }
                .frame(height: 420)
            }
            .task {
                await apiController.fetchCurrentUser()
            }
            .sheet(isPresented: $isEditingPresented) {
                if let editingPost {
                    EditPostView(post: editingPost)
                        .presentationDetents([.medium])
                }
            }
        }
    }
    
    private func delete(post: Post) async {
        do {
            try await apiController.deletePost(postID: post.postID)
            await apiController.fetchCurrentUser()
        } catch {
            print("Error deleting user post: \(error)")
        }
    }
}

#Preview {
    CurrentUserView()
        .environment(UserAPIRequest())
}

