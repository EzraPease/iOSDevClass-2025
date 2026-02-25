//
//  RandomUserView.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import SwiftUI

struct RandomUserView: View {
    @Environment(RandomUserViewModel.self) private var viewModel
    
    @State private var apiRequest = API()
    @State var users: APIResponse?
    
    var body: some View {
        VStack {
            if let users {
                // TODO: Set up subview
                RandomUserCell(users: users)
            } else {
                    ProgressView()
            }
        }
        .task {
            await loadData()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await loadData()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
    
    func loadData() async  {
        do {
            users = nil
            users = try await apiRequest.fetchUsers()
            print(users as Any)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}

#Preview {
    RootView()
}
