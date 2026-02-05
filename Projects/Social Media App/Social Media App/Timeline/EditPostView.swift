import SwiftUI

struct EditPostView: View {
    @Environment(UserAPIRequest.self) private var apiController
    @Environment(\.dismiss) private var dismiss
    
    let post: Post
    
    @State private var titleText: String = ""
    @State private var bodyText: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $titleText)
                        TextField("Body", text: $bodyText, axis: .vertical)
                    }
                }
                .navigationTitle("Edit Post")
                .navigationBarTitleDisplayMode(.inline)
                
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.horizontal)
                }
                
                Button("Save Changes") {
                    Task {
                        await saveChanges()
                    }
                }
                .padding()
                .glassEffect()
            }
        }
        .onAppear {
            titleText = post.title
            bodyText = post.body
        }
    }
    
    private func saveChanges() async {
        guard !titleText.isEmpty, !bodyText.isEmpty else {
            await MainActor.run {
                errorMessage = "Title and body are required."
            }
            return
        }
        
        do {
            _ = try await apiController.updatePost(
                postID: post.postID,
                title: titleText,
                bodyText: bodyText
            )
            await MainActor.run {
                dismiss()
            }
        } catch {
            await MainActor.run {
                errorMessage = "Failed to update post. Please try again."
            }
        }
    }
}

#Preview {
    EditPostView(
        post: Post(
            postID: UUID(),
            title: "Example",
            body: "Body",
            authorUserName: "user",
            authorUserId: UUID(),
            likes: 0,
            userLiked: false,
            numComments: 0,
            createdDate: Date()
        )
    )
    .environment(UserAPIRequest())
}

