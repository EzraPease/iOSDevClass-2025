//
//  MainTabView.swift
//  Recipe Tracker (Navigation Lab)
//
//  Created by Jane Madsen on 10/8/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MyRecipesScreen()
                .tabItem {
                    Label("My Recipies", systemImage: "folder")
                }
            
            DiscoverScreen()
                .tabItem {
                    Label("Discover Recipies", systemImage: "globe")
                }
        }
    }
}



#Preview {
    MainTabView()
}
