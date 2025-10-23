//
//  AppBackground.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/23/25.
//

import SwiftUI


struct AppBackground: View {
    var body: some View {
        LinearGradient(colors: [.color1, .color2],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}
