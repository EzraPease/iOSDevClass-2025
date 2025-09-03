//
//  ContentView.swift
//  mtecClassTestApp
//
//  Created by Ezra Pease on 8/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(randomNumber())")
                .font(.largeTitle)
        }
        .padding()
    }
    
    func randomNumber() -> Int {
        let randomNumber = Int.random(in: 1...100)
        return randomNumber
    }
}

#Preview {
    ContentView()
}
