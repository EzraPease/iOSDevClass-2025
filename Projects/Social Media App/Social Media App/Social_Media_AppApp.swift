//
//  Social_Media_AppApp.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

@main
struct Social_Media_AppApp: App {
    @State private var userAPIRequest = UserAPIRequest()
    
    var body: some Scene {
        WindowGroup {
            SocialMediaView()
                .environment(userAPIRequest)
        }
    }
}
