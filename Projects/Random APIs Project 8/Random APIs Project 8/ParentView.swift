//
//  ContentView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI

struct ParentView: View {
    @State private var dogViewModel = DogListViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                DogsView(apiController: DogAPIController())
                    .environment(dogViewModel)
                    .tabItem {
                        Label("Dogs", systemImage: "dog.fill")
                    }
                USARepsView(apiController: RepresentativeAPIController())
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
