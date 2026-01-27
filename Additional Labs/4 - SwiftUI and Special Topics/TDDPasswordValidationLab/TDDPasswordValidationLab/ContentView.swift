//
//  ContentView.swift
//  TDDPasswordValidationLab
//
//  Created by Ezra Pease on 1/27/26.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = FineHeresAViewModelBozo()
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.cyan)
                .overlay {
                    VStack {
                        Text("Password :3")
                            .bold()
                        TextField("Enter Password Bozo", text: $viewModel.password)
                            .padding()
                            .glassEffect()
                    }
                    .padding()
                }
        }
        .padding()
        .onChange(of: viewModel.password) { _, newValue in
            viewModel.validatePassword()
        }
    }
}

#Preview {
    ContentView()
}
