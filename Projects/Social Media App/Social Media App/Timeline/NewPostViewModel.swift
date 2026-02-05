//
//  NewPostView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/12/25.
//

import SwiftUI


struct NewPostViewModel: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(UserAPIRequest.self) private var apiController
    
    @State private var titleText = ""
    @State private var descriptionText = ""
    @State private var imageURL = ""
    @State private var errorMessage: String?
    
    var body: some View {
            List {
                Section {
                    TextField("Title", text: $titleText)
                    TextField("Description", text: $descriptionText)
                }
                Section {
                    TextField("Image URL", text: $imageURL)
                }
            }
        .navigationTitle("New Post")
        .navigationBarTitleDisplayMode(.inline)
        Button("Submit") {
            Task {
                await submitPost()
            }
        }
        .padding()
        .glassEffect()
    }
    
    private func submitPost() async {
        guard !titleText.isEmpty, !descriptionText.isEmpty else {
            await MainActor.run {
                errorMessage = "Title and description are required."
            }
            return
        }
        
        do {
            _ = try await apiController.createPost(title: titleText, bodyText: descriptionText)
            await MainActor.run {
                dismiss()
            }
        } catch {
            await MainActor.run {
                errorMessage = "Failed to create post. Please try again."
            }
        }
    }
}


#Preview {
    NewPostViewModel()
        .environment(UserAPIRequest())
}
