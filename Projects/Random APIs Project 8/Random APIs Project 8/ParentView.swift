//
//  ContentView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI

struct ParentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                DogsView(apiController: DogAPIController())
                    .tabItem {
                        Label("Dogs", systemImage: "dog.fill")
                    }
                USARepsView()
                    .tabItem {
                        Label("USA Reps", systemImage: "person.2.shield")
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ParentView()
}
