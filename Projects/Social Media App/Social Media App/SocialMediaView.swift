//
//  ContentView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

struct SocialMediaView: View {
    
    
    
    var body: some View {
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
    }
}

#Preview {
    SocialMediaView()
}
