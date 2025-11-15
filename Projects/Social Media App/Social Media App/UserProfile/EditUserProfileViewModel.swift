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
            TextField("First Name", text: $viewModel.currentUser.firstName)
        }
        .task {
            await viewModel.fetchCurrentUser()
        }
    }
}



#Preview {
    EditUserProfileViewModel()
}
