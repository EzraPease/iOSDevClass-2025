//
//  ContentView.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
           RandomUserView()
        }
    }
}

#Preview {
    RootView()
}
