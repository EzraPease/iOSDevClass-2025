import SwiftUI

struct LoginView: View {
    @Environment(UserAPIRequest.self) private var apiController
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Sign In")
                    .font(.largeTitle)
                    .bold()
                
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
                
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Button {
                    Task {
                        await signIn()
                    }
                } label: {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(isLoading || email.isEmpty || password.isEmpty)
                .padding()
                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 12))
                .foregroundColor(.white)
                .padding(.top, 12)
                .opacity(isLoading || email.isEmpty || password.isEmpty ? 0.5 : 1)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func signIn() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            _ = try await apiController.login(email: email, password: password)
        } catch {
            await MainActor.run {
                errorMessage = "Invalid email or password. Please try again."
            }
        }
        
        await MainActor.run {
            isLoading = false
        }
    }
}

#Preview {
    LoginView()
        .environment(UserAPIRequest())
}

