//
//  EditUserProfileSubviewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI


struct EditUserProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment var viewModel: CurrentUserViewModel
    @State private var firstName = ""
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $firstName)
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
        .onAppear {
            firstName = viewModel.currentUser?.firstName ?? ""
        }
        .task {
            await viewModel.fetchCurrentUser()
        }
    }
}



#Preview {
    EditUserProfileViewModel().environment(CurrentUserViewModel())
}
