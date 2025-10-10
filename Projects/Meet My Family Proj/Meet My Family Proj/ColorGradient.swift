//
//  ColorGradient.swift
//  Meet My Family Proj
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI

struct AppBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RadialGradient(colors: [._1DesertSand, ._2Celadon, ._3CambrigeBlue, ._4Cerulean, ._5MidnightGreen],
                           center: .topLeading,
                           startRadius: 100,
                           endRadius: 1100)
            .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackground() -> some View {
        modifier(AppBackground())
    }
}
