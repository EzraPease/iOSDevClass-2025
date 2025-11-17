//
//  TimeLineView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/12/25.
//

import SwiftUI


struct TimeLineView: View {
    @State private var viewModel = TimeLineViewModel()
    @State private var commentsPresented = false
    @State private var selectedPost: PostViewModel? = nil
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.backgroundWhite, .backgroundWhite, .gray],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                VStack {
                    Text("Timeline")
                        .font(.largeTitle)
                        .bold()
                        .underline()
                    //                .frame(maxHeight: .infinity)
                        .padding()
                    ScrollView {
                        ForEach(viewModel.timeLinePosts.indices.shuffled(), id: \.self) { index in
                            let post = viewModel.timeLinePosts[index]
                            VStack {
                                Text(post.title)
                                
                                if let image = post.image {
                                    AsyncImage(url: image) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(maxWidth: 400, maxHeight: 400)
                                            //                                    .scaledToFit()
                                                .padding()
                                        case .failure:
                                            Image(systemName: "photo")
                                            //                                        .resizable()
                                            //                                        .scaledToFit()
                                        default:
                                            ProgressView()
                                        }
                                    }
                                }
                                Text(post.description)
                                HStack {
                                    HStack {
                                        Text("\(post.likes)")
                                        Image(systemName: "hand.thumbsup")
                                    }
                                    .padding()
                                    Button {
                                        selectedPost = post
                                        commentsPresented = true
                                    } label: {
                                        Text("\(post.commentsList.count)")
                                        Image(systemName: "message")
                                    }
                                    .padding()
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $commentsPresented) {
            NavigationStack {
                if let selectedPost {
                    CommentsView(post: selectedPost)
                        .presentationDetents([.medium, .large])
                } else {
                    Text("No Post Selected")
                }
            }
        }
    }
}

#Preview {
    TimeLineView()
}
