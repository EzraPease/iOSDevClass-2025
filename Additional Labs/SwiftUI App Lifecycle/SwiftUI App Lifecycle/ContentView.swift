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
    
    @State private var eventScene = Events()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("App Status:")
                    .bold()
                    .underline()
                    .font(.largeTitle)
                    .padding()
                Text("\(eventScene.scene)")
                    .onChange(of: scenePhase) { _, newEvent in
                        if newEvent == .inactive {
                            eventScene.scene.append("\nApp no longer active")
                        } else if newEvent == .active {
                            eventScene.scene.append("\nApp now active")
                        } else if newEvent == .background {
                            eventScene.scene.append("\nApp backgrounded")
                        }
                    }
                    .toolbar {
                        NavigationLink("Other Status Stuff") {
                            SecondContentView()
                        }
                    }
            }
            .onAppear {
                print("First view appeared")
            }
        }
    }
}


struct SecondContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "dog.fill")
                .resizable()
                .scaledToFit()
                .padding()
                .onAppear {
                    print("SecondContentView Appeared")
                }
        }
        .onDisappear() {
            print("The second view is no more")
        }
    }
}

#Preview {
    ContentView()
}
