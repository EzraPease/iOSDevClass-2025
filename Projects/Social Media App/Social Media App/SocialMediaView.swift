//
//  ContentView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI


struct SocialMediaView: View {
    @Environment(UserAPIRequest.self) private var apiController
    @State var newPostPresented = false
    @State var editUserPresented = false
    
    var body: some View {
        NavigationStack {
            TabView {
                CurrentUserView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                
                TimeLineView(viewModel: TimeLineViewModel(apiController: apiController))
                    .tabItem {
                        Label("Timeline", systemImage: "person.3.fill")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newPostPresented = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        editUserPresented = true
                    } label: {
                        //                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("Edit Profile")
                    }
                }
            }
            .sheet(isPresented: $editUserPresented) {
                NavigationStack {
                    EditUserProfileView()
                        .environment(apiController)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
            .sheet(isPresented: $newPostPresented) {
                NavigationStack {
                    NewPostViewModel()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
}

#Preview {
    SocialMediaView()
}
