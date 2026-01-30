//
//  TimeLineView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/12/25.
//

import SwiftUI


struct TimeLineView: View {
//    @Environment(TimeLineViewModel.self) private var timeLineVM
    @State private var viewModel: TimeLineViewModel
    @State private var commentsPresented: Bool
    @State private var selectedPost: Post? = nil
    
    init(viewModel: TimeLineViewModel, commentsPresented: Bool = false, selectedPost: Post? = nil) {
        self.viewModel = viewModel
        self.commentsPresented = commentsPresented
        self.selectedPost = selectedPost
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
                        .padding()
                    ScrollView {
                        ForEach(viewModel.timeLinePosts.indices, id: \.self) { index in
                            let post = viewModel.timeLinePosts[index]
                            VStack {
                                Text(post.title)
                                    .font(.title2)
                                    .bold()
                                if let image = post.image {
                                    AsyncImage(url: image) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(maxWidth: 400, maxHeight: 400)
                                                .padding()
                                        case .failure:
                                            Image(systemName: "photo")
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
                                    .foregroundStyle(.black)
                                    .padding()
                                }
                                Spacer()
                            }
                            .background(LinearGradient(colors: [.teal, .teal, .indigo],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing),
                                        in: RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 7)
                            .padding(20)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchTimeLine()
            await viewModel.fetchCurrentUserPosts()
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
    TimeLineView(viewModel: TimeLineViewModel())
}
