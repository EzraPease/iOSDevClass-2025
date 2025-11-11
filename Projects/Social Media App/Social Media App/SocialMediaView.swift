//
//  ContentView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

struct ParentView: View {
    @State private var viewModel = CurrentUserViewModel()
    
    
    var body: some View {
        VStack {
            ZStack {
                if let temporaryBackgroundPhoto = URL(string: "https://picsum.photos/400/200") { // Background Photo
                    AsyncImage(url: temporaryBackgroundPhoto) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .ignoresSafeArea()
                                .frame(width: .infinity, height: 200)
//                                .clipShape(Rectangle())
                        case .failure:
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
                if let temporaryProfilePhoto = URL(string:
                                                    "https://hws.dev/paul.jpg") { // Profile Photo
                    AsyncImage(url: temporaryProfilePhoto) { phase in
                        switch phase {
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
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // pin the stack to top
                    .padding()
                    .offset(y: 135)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.gray)
                }
                Text(viewModel.currentUser[0].firstName)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // pin the stack to top
//        .padding()
    }
}

#Preview {
    ParentView()
}
