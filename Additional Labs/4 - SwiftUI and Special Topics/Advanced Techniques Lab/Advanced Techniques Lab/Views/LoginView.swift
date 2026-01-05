//
//  LoginView.swift
//  Advanced Techniques Lab
//
//  Created by Ezra Pease on 1/5/26.
//

import SwiftUI


struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginState: LoginViewModel.LoginState = .idle
    @State private var viewModel = LoginViewModel()
    @State private var passwordHidden = true
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
                switch loginState {
                case .idle:
                    Text("")
                case .success:
                    Text("Success")
                        .foregroundStyle(.green)
                case .loading:
                    ProgressView("Loading...")
                case .error(let string):
                    Text(string)
                        .foregroundStyle(.red)
                }
//            .frame(height: 20)
//            .padding()
            
            TextField("Username", text: $username)
                .modifier(CustomTextFeildStyle())
                HStack {
                    if passwordHidden {
                        SecureField("Password", text: $password)
                            .modifier(CustomTextFeildStyle())
                    } else {
                        TextField("Password", text: $password)
                            .modifier(CustomTextFeildStyle())
                    }
                    Button {
                        showPassword()
                    } label: {
                        if passwordHidden {
                            Image(systemName: "eye.fill")
                        } else {
                            Image(systemName: "eye.slash.fill")
                        }
                    }
                }
            }
            
            Button("Login") {
                Task { await attemptLogin() }
            }
            .buttonStyle(CustomButtonStyle())
                .padding(.vertical)
            VStack(alignment: .trailing) {
                Button("Forgot Password") {
                    
                }
                .buttonStyle(SecondCustomButtonStyle())
            }
        }
        .padding()
    }
    
    func showPassword() {
        passwordHidden.toggle()
    }
    
    func attemptLogin() async {
        loginState = .loading
        
        // Loading...
        try? await Task.sleep(for: .seconds(1))
        if username.isEmpty || password.isEmpty {
            loginState = .error("Please input username and password")
        } else {
            loginState = .success
        }
        
        try? await Task.sleep(for: .seconds(5))
        loginState = .idle
    }
}



#Preview {
    LoginView()
}
