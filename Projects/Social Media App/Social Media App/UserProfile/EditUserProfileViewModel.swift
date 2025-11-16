//
//  EditUserProfileSubviewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI


struct EditUserProfileViewModel: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CurrentUserViewModel()
    
    var body: some View {
        List {
            Section {
//                TextField("First Name", text: $viewModel.firstName)
                Text("First Name")
                Text("Last Name")
            }
            Section {
                Text("Bio")
                Text("Tech Interests")
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
    EditUserProfileViewModel()
}
