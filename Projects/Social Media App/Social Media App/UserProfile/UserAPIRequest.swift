//
//  CurrentUserViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

protocol UserAPICall {
    func fetchCurrentUser() async
}

@Observable
class UserAPIRequest: UserAPICall {
    var currentUser: CurrentUser?
    var recentPost: Post?
    var userPosts: [Post]
    var userLoggedIn = false
    
    init(currentUser: CurrentUser? = nil, recentPost: Post? = nil, userPosts: [Post] = []) {
        self.currentUser = currentUser
        self.recentPost = recentPost
        self.userPosts = userPosts
    }
    
    // have the state to display, like this current user (point up)
    
    // make a function that fetches the data that you want to display. Then set the variable
    
    func fetchCurrentUser() async {
        // this is where the network call will go.
        // if you want to simulate this
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        currentUser = CurrentUser(firstName: "Ezra",
                                  lastName: "Pease",
                                  userName: "Ezra Pease",
                                  userUUID: UUID(),
                                  bio: "Insert user bio here",
                                  techInterests: "I really like computers, computer good yes")
        
        if !userPosts.isEmpty {
            recentPost = userPosts.last
        }
    }
    
//     GET
    func getAPIRequest() async throws {
        do {
        let request = URLRequest(url: URL(string: "https://social-media-app.ryanplitt.com")!)
        
        let session = URLSession.shared
        
            let task = try await session.data(for: request)
        } catch {
            print("uh oh, there was a problem: \(error)")
            throw error
        }
    }
    
    
    
//    POST
    struct LoginInput: Codable {
        let email: String
        let password: String
        
    }

    struct LoginResponse: Codable {
        let firstName: String
        let lastName: String
        let email: String
        let userUUID: UUID //or String
        let secret: UUID //or String
        let userName: String
    }

    enum LoginError: Error {
        case badResponse
        case systemError
    }
    func login(email: String, password: String) async throws -> LoginResponse {
        let loginInput = LoginInput(email: email, password: password)
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(loginInput)
            
            var request = URLRequest(url: URL(string: "https://www.google.com")!)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            
            let (responseData, urlResponse) = try await session.data(for: request)
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(
                        LoginResponse.self,
                        from: responseData
                    )
                    return response
                } else {
                    print("error status: \(httpResponse.statusCode)")
                    throw LoginError.badResponse
                }
            } else {
                print("oh no something bad happened: \(urlResponse)")
                throw LoginError.systemError
            }
        } catch {
            print("error: \(error)")
            throw error
        }
    }
}
