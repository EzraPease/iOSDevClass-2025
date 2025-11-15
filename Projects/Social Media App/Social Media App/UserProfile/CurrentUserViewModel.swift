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
        
        recentPost = PostViewModel(image: URL(string: "https://picsum.photos/2000/2000"),
                                   title: "Post Title",
                                   description: "Post Description",
                                   likes: 320,
                                   comments: 137)
    }
}

struct CurrentUserView: View {
    @State private var viewModel = CurrentUserViewModel()
    @State private var profileTab = 0
    @State private var tabs = ["Profile", "Timeline"]
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.backgroundWhite, .backgroundWhite, .gray],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                ZStack {
                    if let temporaryBackgroundPhoto = viewModel.currentUser?.backgroundCoverPhoto { // Background Photo
                        AsyncImage(url: temporaryBackgroundPhoto) { phase in
                            switch phase { // Checks image loading status and displays coresponding image depending
                            case .empty:
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            case .success(let image): // Displays if image loads correctly
                                image
                                    .resizable()
                                    .ignoresSafeArea()
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                            case .failure: // Default image when image fails to load
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 400, height: 200)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // pin the stack to top
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.gray)
                    }
                    if let temporaryProfilePhoto = viewModel.currentUser?.profilePhoto { // Profile Photo
                        AsyncImage(url: temporaryProfilePhoto) { phase in
                            switch phase { // Checks image loading status and displays coresponding image depending
                            case .empty:
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .foregroundColor(.gray)
                                    .clipShape(Circle())
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                        .offset(y: 135)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.gray)
                    }
                }
                ScrollView { // Displays user data and recent post
                    if let currentUser = viewModel.currentUser {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                HStack { // Username
                                    Text(currentUser.firstName)
                                    Text(currentUser.lastName)
                                }
                                .font(.title)
                                .bold()
                                
                                Text(currentUser.userBio) // User Bio
                                    .italic()
                                    .font(.footnote)
                            }
                            .padding(.vertical, 40)
                            Text(currentUser.techInterests) // User Tech Interests
                                .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                    } else {
                        // Loading indicator
                        ProgressView()
                    }
                    if let recentPost = viewModel.recentPost {
                        VStack {
                            Text(recentPost.title)
                                .bold()
                                .font(.headline)
                            if let recentPostImage = recentPost.image {
                                AsyncImage(url: recentPostImage) { image in
                                    image
                                        .image?
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 400, maxHeight: 400)
                                        .padding()
                                }
                            }
                            HStack { // Likes and Comments
                                HStack {
                                    Text("\(recentPost.likes)")
                                    Image(systemName: "hand.thumbsup")
                                }
                                .padding()
                                HStack {
                                    Text("\(recentPost.comments)")
                                    Image(systemName: "message")
                                }
                                .padding()
                            }
                            Text(recentPost.description)
                        }
                    } else { // Displays when nothing else has loaded
                        Text("Nothing here yet...")
                            .font(.largeTitle)
                    }
                }
                .frame(height: 420)
            }
        }
        .task {
            await viewModel.fetchCurrentUser()
        }
    }
}


#Preview {
    SocialMediaView()
}
