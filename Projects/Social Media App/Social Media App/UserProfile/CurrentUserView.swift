//
//  CurrentUserView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/18/25.
//

import SwiftUI


struct CurrentUserView: View {
    @Environment(UserAPIRequest.self) private var apiController
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
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.gray)

                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.gray)
                        }
                    }
                    ScrollView { // Displays user data and recent post
                        if let currentUser = apiController.currentUser {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    HStack { // Username
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
                        } else {
                            // Loading indicator
                            ProgressView()
                        }
                        if let recentPost = apiController.recentPost {
                            VStack {
                                Text(recentPost.title)
                                    .bold()
                                    .font(.headline)
//                                if let recentPostImage = recentPost.image {
//                                    AsyncImage(url: recentPostImage) { image in
//                                        image
//                                            .image?
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(maxWidth: 400, maxHeight: 400)
//                                            .padding()
//                                    }
//                                }
//                                HStack { // Likes and Comments
//                                    HStack {
//                                        Text("\(recentPost.likes)")
//                                        Image(systemName: "hand.thumbsup")
//                                    }
//                                    .padding()
//                                    HStack {
//                                        Text("\(recentPost.comments)")
//                                        Image(systemName: "message")
//                                    }
//                                    .padding()
//                                }
                                Text(recentPost.body)
                            }
                        } else { // Displays when nothing else has loaded
                            Text("Nothing here yet...")
                                .font(.largeTitle)
                        }
                    }
                    .frame(height: 420)
                }
            .task {
                await apiController.fetchCurrentUser()
            }
        }
    }



#Preview {
    SocialMediaView()
}
