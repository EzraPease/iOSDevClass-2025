//
//  ContentView.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/4/25.
//

import SwiftUI

struct RootView: View {
    @State private var router = DragonRouter()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            DragonListView()
                .navigationDestination(for: DragonRouter.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environment(router)
    }
}

#Preview {
    RootView()
}
