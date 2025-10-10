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
                //                ZStack {
                //                    VStack {
                //                        Text("Welcome,")
                //                        Text("Meet my Family")
                //                    }
                //                    .foregroundStyle(.gray)
                //                    .bold()
                //                    .offset(x: 2, y: 1)
                VStack {
                    Text("Welcome,")
                    Text("Meet my Family")
                    //                    }
                }
                .shadow(color: .black.opacity(0.35), radius: 6, x: 2, y: 1)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .padding()
            }
            .appBackground()
        }
    }
}

#Preview {
    WelcomeView()
}
