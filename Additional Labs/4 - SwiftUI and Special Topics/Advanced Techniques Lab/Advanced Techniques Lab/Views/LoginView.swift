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
    @State private var showForgotPassword = false
    @State private var loginDisabled = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            VStack {
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
            }
            .frame(height: 20)
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
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
                            Image(systemName: "eye.slash.fill")
                        } else {
                            Image(systemName: "eye.fill") 
                        }
                    }
                }
            }
            
            Button("Login") {
                Task { await attemptLogin() }
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.vertical)
            .disabled(loginDisabled)
            VStack(alignment: .trailing) {
                Button("Forgot Password") {
                    Task { await rememberPassword() }
                }
                .buttonStyle(SecondCustomButtonStyle())
            }
            
            Text("Congrats! You now remember your password! :D")
                .padding(1)
                .opacity(showForgotPassword ? 1 : 0)
        }
        .padding()
    }
    
    func rememberPassword() async {
        showForgotPassword = true
        
        try? await Task.sleep(for: .seconds(5))
        showForgotPassword = false
    }
    
    func showPassword() {
        passwordHidden.toggle()
    }
    
    func attemptLogin() async {
        loginDisabled = true
        loginState = .loading
        
        // Loading...
        try? await Task.sleep(for: .seconds(1))
        if username.isEmpty || password.isEmpty {
            loginState = .error("Please input username and password")
            loginDisabled = false
        } else {
            loginState = .success
            try? await Task.sleep(for: .seconds(1))
            username = ""
            password = ""
            loginDisabled = false
        }
        
        try? await Task.sleep(for: .seconds(3))
        loginState = .idle
    }
}



#Preview {
    LoginView()
}
