//
//  SwiftUITextLabApp.swift
//  SwiftUITextLab
//
//  Created by Jane Madsen on 9/10/25.
//

import SwiftUI

@main
struct SwiftUITextLabApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            TopFiveFriendsView()
                .tabItem {
                    Label("Friends", systemImage: "person.3.sequence")
                }
            BlogPostView()
                .tabItem {
                    Label("Blog", systemImage: "doc.text")
                }
        }
    }
}


