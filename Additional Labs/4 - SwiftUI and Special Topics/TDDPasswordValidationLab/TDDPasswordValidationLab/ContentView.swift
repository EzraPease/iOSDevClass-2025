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
                        if !viewModel.password.isEmpty {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.blue)
                            .opacity(0.45)
                            .frame(height: 275)
                            .overlay {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Password must:")
                                                .bold()
                                                .padding(.vertical, 4)
                                            
                                            Spacer()
                                        }
                                        // 8 to 30 Characters
                                            HStack {
                                                Image(systemName: (viewModel.passwordValidityChecks[0] && viewModel.passwordValidityChecks[1]) ? "checkmark.circle.fill" : "x.circle.fill")
                                                    .foregroundStyle((viewModel.passwordValidityChecks[0] && viewModel.passwordValidityChecks[1]) ? .green : .red)
                                                Text("Contain 8 to 30 characters")
                                            }
                                        // Upper and Lowercase letters
                                            HStack {
                                                Image(systemName: (viewModel.passwordValidityChecks[2] && viewModel.passwordValidityChecks[3]) ? "checkmark.circle.fill" : "x.circle.fill")
                                                    .foregroundStyle((viewModel.passwordValidityChecks[2] && viewModel.passwordValidityChecks[3]) ? .green : .red)
                                                Text("Contain both lower and uppercase letters")
                                            }
                                        // Number
                                            HStack {
                                                Image(systemName: (viewModel.passwordValidityChecks[4]) ? "checkmark.circle.fill" : "x.circle.fill")
                                                    .foregroundStyle((viewModel.passwordValidityChecks[4]) ? .green : .red)
                                                Text("Contain 1 number")
                                            }
                                        // Special Character
                                            HStack {
                                                Image(systemName: (viewModel.passwordValidityChecks[5]) ? "checkmark.circle.fill" : "x.circle.fill")
                                                    .foregroundStyle((viewModel.passwordValidityChecks[5]) ? .green : .red)
                                                Text("Contain 1 special character '!@#$%^&*-+'")
                                            }
                                        // Sequence
                                            HStack {
                                                Image(systemName: (viewModel.passwordValidityChecks[6]) ? "checkmark.circle.fill" : "x.circle.fill")
                                                    .foregroundStyle((viewModel.passwordValidityChecks[6]) ? .green : .red)
                                                Text("Not contain letter or number sequences like 'abc' '123' '4444' 'qwerty'")
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                    }
                    .padding()
                }
        }
        .padding()
        .onAppear {
            viewModel.validatePassword()
            print(viewModel.passwordValidityChecks)
        }
        .onChange(of: viewModel.password) { _, newValue in
            viewModel.validatePassword()
            print(viewModel.passwordValidityChecks)
        }
    }
}

#Preview {
    ContentView()
}
