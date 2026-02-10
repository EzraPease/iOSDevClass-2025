//
//  EditUserProfileSubviewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI


struct EditUserProfileView: View {
    // TODO: Fix Editing the user profile to change the right data in the API
    @Environment(\.dismiss) private var dismiss
    @Environment(UserAPIRequest.self) private var apiController
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userBio = ""
    @State private var userTechInterests = ""
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            Section {
                TextField("Bio", text: $userBio)
                TextField("Tech Interests", text: $userTechInterests)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        Button("Save") {
            Task {
                await saveProfile()
            }
        }
        .padding()
        .glassEffect()
        .task {
            await apiController.fetchCurrentUser()
            if let currentUser = apiController.currentUser {
                firstName = currentUser.firstName
                lastName = currentUser.lastName
                userBio = currentUser.bio ?? ""
                userTechInterests = currentUser.techInterests ?? ""
            }
        }
    }
    
    private func saveProfile() async {
        do {
            let fullUserName = "\(firstName) \(lastName)"
            try await apiController.updateProfile(
                userName: fullUserName,
                bio: userBio,
                techInterests: userTechInterests
            )
            await apiController.fetchCurrentUser()
            await MainActor.run {
                dismiss()
            }
        } catch {
            print("Error updating profile: \(error)")
        }
    }
}



#Preview {
    EditUserProfileView().environment(UserAPIRequest())
}
