//
//  CurrentUserViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

@Observable
class CurrentUserViewModel {
    var currentUser: CurrentUser =
        CurrentUser(firstName: "Ezra",
                    lastName: "Pease",
                    userBio: "Insert user bio here",
                    techInterests: "I really like computures, computure good yes")
    
}

struct CurrentUserView: View {
    @State private var viewModel = CurrentUserViewModel()
    
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
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
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(viewModel.currentUser.firstName)
                                Text(viewModel.currentUser.lastName)
                            }
                            .font(.title)
                            .bold()
                            
                            Text(viewModel.currentUser.userBio)
                                .italic()
                                .font(.footnote)
                            Text(viewModel.currentUser.techInterests)
                                .padding(.vertical)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    
                    Spacer(minLength: 280)
                    
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
                                .clipShape(Circle())
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    .offset(y: 135)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
