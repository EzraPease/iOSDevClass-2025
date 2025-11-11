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
        ZStack {
            if let temporaryBackgroundPhoto = URL(string: "https://placehold.co/1200x800/1e293b/ffffff?text=Background") {
                AsyncImage(url: temporaryBackgroundPhoto) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .ignoresSafeArea()
                            .frame(width: .infinity, height: .infinity)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            }
            if let temporaryProfilePhoto = URL(string:
                                "https://hws.dev/paul.jpg") {
                AsyncImage(url: temporaryProfilePhoto) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100, alignment: .topLeading)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .topLeading)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .topLeading)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ParentView()
}
