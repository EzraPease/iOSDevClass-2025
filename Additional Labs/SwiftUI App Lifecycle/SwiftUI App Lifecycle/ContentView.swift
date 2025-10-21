//
//  ContentView.swift
//  SwiftUI App Lifecycle
//
//  Created by Ezra Pease on 10/21/25.
//

import SwiftUI

struct Events {
var scene: String = ""
}



struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("\(Events.scene)")
            .onChange(of: scenePhase) { _, newEvent in
                if newEvent == .inactive {
                    
                } else if newEvent == .active {
                    
                } else if newEvent == .background {
                    
                }
            }
    }
}

#Preview {
    ContentView()
}
