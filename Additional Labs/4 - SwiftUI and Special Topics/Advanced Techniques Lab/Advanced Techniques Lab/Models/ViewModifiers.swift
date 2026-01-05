//
//  LoginViewModel.swift
//  Advanced Techniques Lab
//
//  Created by Ezra Pease on 1/5/26.
//

import SwiftUI


    struct CustomTextFeildStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .frame(width: 300, height: 50)
                .background(.regularMaterial)
                .cornerRadius(20)
                .shadow(radius: 6)
        }
    }


#Preview {
    LoginView()
}
