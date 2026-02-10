//
//  TimeLineView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/12/25.
//

import SwiftUI


struct TimeLineView: View {
    @State private var viewModel: TimeLineViewModel
    @Environment(UserAPIRequest.self) private var apiController
    @State private var commentsPresented: Bool
    @State private var selectedPost: Post? = nil
    
    init(viewModel: TimeLineViewModel, commentsPresented: Bool = false) {
        self.viewModel = viewModel
        self.commentsPresented = commentsPresented
    }
    
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
                        .padding(.top)
                    ScrollView {
                        ForEach(viewModel.timeLinePosts, id: \.id) { post in
                            VStack {
                                Text(post.title)
                                    .font(.title2)
                                    .bold()
                                Text(post.body)
                                    .padding(.top, 4)
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
                                .padding(.vertical, 4)
                                
                                HStack {
                                    Text(post.authorUserName)
                                    Spacer()
                                    Text(post.createdDate.formatted(date: .abbreviated, time: .shortened))
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                Spacer()
                            }
                            .background(LinearGradient(colors: [.teal, .teal, .indigo],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing),
                                        in: RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 7)
                            .padding(20)
                            .contextMenu {
                                if let currentUser = apiController.currentUser,
                                   currentUser.userUUID == post.authorUserId {
                                    Button(role: .destructive) {
                                        Task {
                                            await viewModel.delete(post: post)
                                        }
                                    } label: {
                                        Label("Delete Post", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchTimeLine()
            print("\(viewModel.timeLinePosts.count) posts loaded")
            viewModel.timeLinePosts.shuffle()
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
    let api = UserAPIRequest()
    TimeLineView(viewModel: TimeLineViewModel(apiController: api))
        .environment(api)
}
