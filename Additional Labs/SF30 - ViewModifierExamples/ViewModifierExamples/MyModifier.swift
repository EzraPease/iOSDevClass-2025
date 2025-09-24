//
//  MyModifier.swift
//  ViewModifierExamples
//
//  Created by Toby Youngberg on 9/15/25.
//

import SwiftUI

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .bold(true)
        .italic(true)
        .strikethrough(true, pattern: .dashDotDot, color: .green)
        .underline(false)
        .tint(.blue)
        .border(.red, width: 1)
//        .overlay(Color.red.frame(width: 10, height: 10))
        .padding(50)
        .background(.purple)
//        .hidden()
//        .frame(width: 15, height: 30)
        .offset(x: 13, y: 68)
        .position(x: 100, y: 5)
    }
}

extension View {
    func myModifier() -> some View {
        modifier(MyModifier())
    }
}

struct FancyViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .bold()
            .italic()
            .font(.largeTitle)
            .frame(width: 300, height: 200)
            .padding(50)
            .background(
                LinearGradient(
                    colors: [.blue, .green, .yellow],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                in: Circle()
            )
            .offset(y: -100)
    }
}

extension View {
    func fancyViewModifier() -> some View {
        modifier(FancyViewModifier())
    }
}

