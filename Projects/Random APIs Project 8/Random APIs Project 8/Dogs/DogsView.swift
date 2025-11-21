//
//  DogsView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


struct DogsView: View {
    @State private var apiController: DogAPIController
    @State private var imageURL: URL?
    @State private var dogName = ""
    
    init(apiController: DogAPIController) {
        self.apiController = apiController
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 4)
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 300)
            }
            TextField("Name Me?", text: $dogName)
        }
        .task {
            do {
                let urlString = try await apiController.fetchDogImage()
                imageURL = URL(string: urlString)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ParentView()
}
