//
//  ContentView.swift
//  Follow Along
//
//  Created by Ezra Pease on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    
    let people = ["andy", "tom", "leslie", "jr", "ron", "ezra"]
    
    var body: some View {
        VStack(alignment:
                .leading) {
                    ForEach(people, id: \.self) { person in
                        Text("Hi, \(person)")
                    }
                }
    }
}

#Preview {
    ContentView()
}
