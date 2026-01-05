//
//  Untitled.swift
//  Advanced Techniques Lab
//
//  Created by Ezra Pease on 1/5/26.
//

import SwiftUI


struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 20)
            .foregroundColor(.white)
            .padding()
            .glassEffect()
            .background(configuration.isPressed ? Color.green : Color.blue)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct SecondCustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 20)
            .foregroundStyle(.white)
            .padding()
//            .glassEffect()
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

#Preview {
    LoginView()
}
