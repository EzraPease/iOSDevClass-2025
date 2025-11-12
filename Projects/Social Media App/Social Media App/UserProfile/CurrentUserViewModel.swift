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
    var recentPost: RecentPost?
    
    
    // have the state to display, like this current user (point up)
    
    // make a function that fetches the data that you want to display. Then set the variable
    
    func fetchCurrentUser() async {
        // this is where the network call will go.
        // if you want to simulate this
        try? await Task.sleep(nanoseconds: 2000000000)
        currentUser = CurrentUser(profilePhoto: URL(string: "https://hws.dev/paul.jpg"),
                                  backgroundCoverPhoto: URL(string: "https://picsum.photos/400/200"),
                                  firstName: "Ezra",
                                  lastName: "Pease",
                                  userBio: "Insert user bio here",
                                  techInterests: "I really like computers, computer good yes")
        
    }
    
    func fetchRecentUserPost() async {
        try? await Task.sleep(nanoseconds: 2000000000)
        recentPost = RecentPost(title: "Post Title",
                                description: "Post Description")
    }
}

struct CurrentUserView: View {
    @State private var viewModel = CurrentUserViewModel()
    @State private var profileTab = 0
    @State private var tabs = ["Profile", "Timeline"]
    
    
    var body: some View {
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
                                .frame(width: .infinity, height: 200)
                        case .failure: // Default image when image fails to load
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 400, height: 200)
                                .foregroundColor(.gray)
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
            if let currentUser = viewModel.currentUser {
                ScrollView {
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
                        .padding(.vertical)
                        Text(currentUser.techInterests) // User Tech Interests
                            .padding(.vertical)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
            } else {
                // Loading indicator
                ProgressView()
            }
            
            Spacer(minLength: 280)
            
        }
        .task {
            await viewModel.fetchCurrentUser()
        }
    }
}


#Preview {
    SocialMediaView()
}
