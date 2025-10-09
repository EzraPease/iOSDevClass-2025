//
//  ContentView.swift
//  Meet My Family Proj
//
//  Created by Ezra Pease on 10/9/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            NavigationLink { FamilyListView()
            } label: {
                VStack {
                    Text("Welcome,")
                    Text("Meet my Family")
                }
                .font(.largeTitle)
                .bold()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
