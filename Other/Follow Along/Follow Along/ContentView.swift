//
//  ContentView.swift
//  Follow Along
//
//  Created by Ezra Pease on 9/25/25.
//

import SwiftUI
import Playgrounds



struct ContentView: View {
    
    var body: some View {
        Spacer()
        
        VStack {
            Button(action: {}) {
                Text("Next")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(Color.white)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .foregroundStyle(Color.gray)
            )
            .padding()
            Button(action: {}) {
                Text("Animated Button")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .background(
                Capsule()
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .indigo, .purple],
                        startPoint: .leading,
                        endPoint: .trailing)
                    )
            )
            .padding()
        }
    }
}



#Preview {
    ContentView()
}
