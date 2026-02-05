import SwiftUI

struct RootView: View {
    @Environment(UserAPIRequest.self) private var apiController
    
    var body: some View {
        if apiController.userLoggedIn {
            SocialMediaView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    RootView()
        .environment(UserAPIRequest())
}

