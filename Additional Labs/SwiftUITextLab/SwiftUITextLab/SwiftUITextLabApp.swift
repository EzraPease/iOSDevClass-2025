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


struct ProfileView: View {
    var body: some View {
        Text ("MikeIGL")
            .foregroundStyle(.white)
            .font(.custom("AcademyEngravedLetPlain", size: 40))
            .underline()
            .padding(100)
            .background(
                LinearGradient(
                    colors: [.mint, .yellow],
                    startPoint: .center,
                    endPoint: .topTrailing
                ),
                in: Capsule()
            )
            .position(x: 200, y: 200)
        Text ("I never know what I should put here")
            .foregroundStyle(.white)
            .font(.custom("ArialRoundedMTBold", size: 15))
            .position(x: 200, y: -120)
        Text ("Ezra Pease")
            .italic()
            .font(.title3)
        Text ("Orem")
            .italic()
            .font(.title3)
        Text("iOS Develelopment")
            .font(.custom("SnellRoundhand", size: 22))
    }
}

struct TopFiveFriendsView: View {
    var body: some View {
        Text ("❤️ - Alison")
            .foregroundStyle(.red)
            .font(.custom("Zapfino", size: 20))
        Text ("🏭 - Mathew")
            .foregroundStyle(.green)
            .font(.custom("Papyrus", size: 20))
        Text ("🎶 - James")
            .foregroundStyle(.blue)
            .font(.custom("Herculanum", size: 20))
        Text ("🔫 - Dani")
            .foregroundStyle(.yellow)
            .font(.custom("American Typewriter", size: 20))
        Text ("💂 - AJ")
            .foregroundStyle(.black)
            .font(.footnote)
    }
}

struct BlogPostView: View {
    var body: some View {
        
    }
}

