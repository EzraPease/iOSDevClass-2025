//
//  ContentView.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = AppViewModel()
    
    var body: some View {
        NavigationStack {
            UsersView()
        }
        .environment(viewModel)
    }
}

#Preview {
    ContentView()
}
