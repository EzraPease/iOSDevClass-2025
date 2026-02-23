//
//  Untitled.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) private var context
    @Environment(AppViewModel.self) private var viewModel
    
    @Query(sort: \User.orderIndex) private var userLists: [User]
    
    @State private var addUserShown = false
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(userLists) { user in
                    UserCell(user: user)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let user = userLists[index]
                        viewModel.deleteUser(user: user, context: context)
                    }
                }
                .onMove(perform: move)
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("People")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addUserShown = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Button("Change Selection Amount") {
                        viewModel.changeSelectionAmount(userList: userLists)
                    }
                    Button("Select Random People") {
                        
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $addUserShown) {
            NavigationStack {
                AddUser()
                    .navigationTitle("Add User")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        // 1. Create a mutable copy of the sorted items
        var revisedUsers = userLists
        
        // 2. Perform the move on the array
        revisedUsers.move(fromOffsets: source, toOffset: destination)
        
        // 3. Update the 'orderIndex' for EVERY item to match the new array order
        for reverseIndex in stride(from: revisedUsers.count - 1, through: 0, by: -1) {
            revisedUsers[reverseIndex].orderIndex = reverseIndex
        }
    }
}

#Preview {
    UsersView()
        .environment(AppViewModel())
}
