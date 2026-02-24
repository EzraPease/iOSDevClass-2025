//
//  ContentView.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import SwiftUI

struct RootView: View {
    @State private var viewModel = RandomUserViewModel()
    
    var body: some View {
        NavigationStack {
           RandomUserView()
        }
        .environment(viewModel)
    }
}

#Preview {
    RootView()
}
