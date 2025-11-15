//
//  ContentView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

struct SocialMediaView: View {
    @State var newPostPresented = false
    @State var editUserPresented = false
    
    var body: some View {
        
        NavigationStack {
            TabView {
                CurrentUserView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                
                TimeLineView()
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        editUserPresented = true
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                }
            }
        }
        .sheet(isPresented: $editUserPresented) {
            NavigationStack {
                EditUserProfileViewModel()
            }
        }
        .sheet(isPresented: $newPostPresented) {
            NavigationStack {
                NewPostViewModel()
            }
        }
    }
}

#Preview {
    SocialMediaView()
}
