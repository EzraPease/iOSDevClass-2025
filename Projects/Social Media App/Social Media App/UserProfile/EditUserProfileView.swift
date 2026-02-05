//
//  EditUserProfileSubviewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI


struct EditUserProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(UserAPIRequest.self) private var viewModel
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
            print("Save Button Pressed")
            dismiss()
        }
        .padding()
        .glassEffect()
        .task {
            await viewModel.fetchCurrentUser()
        }
    }
}



#Preview {
    EditUserProfileView().environment(UserAPIRequest())
}
