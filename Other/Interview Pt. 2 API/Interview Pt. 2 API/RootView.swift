//
//  ContentView.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import SwiftUI

struct RootView: View {
    @State private var viewModel = RandomUserViewModel()
    @State private var api = API()
    
    var body: some View {
        NavigationStack {
            TabView {
                RandomUserSettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                RandomUserView()
                    .tabItem {
                        Label("Users", systemImage: "person.3.fill")
                    }
            }
        }
        .environment(viewModel)
        .environment(api)
    }
}

#Preview {
    RootView()
}
