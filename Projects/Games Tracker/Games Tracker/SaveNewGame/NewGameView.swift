//
//  NewGameView.swift
//  Games Tracker
//
//  Created by Ezra Pease on 12/11/25.
//

import SwiftUI



struct NewGameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var gameName = ""
    
    var body: some View {
        VStack {
            TextField("Game Name", text: $gameName)
        }
        .padding()
    }
}
