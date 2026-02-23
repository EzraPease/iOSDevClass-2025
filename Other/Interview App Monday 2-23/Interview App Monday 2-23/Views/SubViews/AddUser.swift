//
//  AddUser.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import SwiftUI
import SwiftData

struct AddUser: View {
    @Environment(AppViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var userLists: [User]
    
    @State private var username = ""
    @State private var emptyUsernameError = false
    
    var body: some View {
        VStack {
            if emptyUsernameError {
                Text("Please input a name")
                    .foregroundStyle(.red)
            }
            TextField("Name...", text: $username)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                .shadow(radius: 13)
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    if username.isEmpty {
                        emptyUsernameError = true
                        Task {
                            try? await Task.sleep(for: .seconds(5))
                            emptyUsernameError = false
                        }
                    } else {
                        viewModel.addUser(user: User(username: username, orderIndex: userLists.count), context: context)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddUser()
        .environment(AppViewModel())
}
