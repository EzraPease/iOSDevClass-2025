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
            .frame(width: 100, height: 20)
            .foregroundColor(.white)
            .padding()
            .glassEffect()
            .background(configuration.isPressed ? Color.blue : Color.green)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

#Preview {
    LoginView()
}
