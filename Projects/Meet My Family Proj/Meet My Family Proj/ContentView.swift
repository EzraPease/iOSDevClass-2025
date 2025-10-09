//
//  ContentView.swift
//  Meet My Family Proj
//
//  Created by Ezra Pease on 10/9/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome!")
        NavigationStack {
            NavigationLink(FamilyListView())
        } label: {
            Text("Meet my Family")
        }
    }
}

#Preview {
    WelcomeView()
}
