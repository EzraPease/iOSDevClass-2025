//
//  EditUserProfileSubviewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI


struct EditUserProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(CurrentUserViewModel.self) private var viewModel: CurrentUserViewModel
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $viewModel.currentUser?.firstName)
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
    EditUserProfileView().environment(CurrentUserViewModel())
}
