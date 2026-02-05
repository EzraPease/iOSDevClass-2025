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
    // Base configuration
    private let baseURL = URL(string: "https://social-media-app.ryanplitt.com")!
    
    var currentUser: CurrentUser? = nil
    var recentPost: Post? = nil
    var userPosts: [Post] = []
    var userLoggedIn = false
    var userSecret: UUID? = nil
    var loggedInEmail: String? = nil
    
    enum APIError: Error {
        case notLoggedIn
        case invalidURL
        case badResponse(statusCode: Int)
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
            let request = URLRequest(url: baseURL)
        
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
        do {
            let url = baseURL.appendingPathComponent("auth/login")

            var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password)
            ]

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = components.percentEncodedQuery?.data(using: .utf8)
            
            let session = URLSession.shared
            
            let (responseData, urlResponse) = try await session.data(for: request)
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(
                        LoginResponse.self,
                        from: responseData
                    )
                    
                    // Persist login state and userSecret for future API calls
                    userLoggedIn = true
                    userSecret = response.secret
                    loggedInEmail = response.email
                    currentUser = CurrentUser(
                        firstName: response.firstName,
                        lastName: response.lastName,
                        userName: response.userName,
                        userUUID: response.userUUID,
                        bio: nil,
                        techInterests: nil,
                        posts: []
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
    
    // MARK: - Authenticated request helpers
    
    /// Builds a URL for a path under the API base URL.
    private func makeURL(path: String, queryItems: [URLQueryItem]? = nil) throws -> URL {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        components.queryItems = queryItems
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        return url
    }
    
    /// Builds a URLRequest, automatically attaching the `userSecret` when `requiresAuth` is true.
    private func makeRequest(
        path: String,
        method: String,
        requiresAuth: Bool = true,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        contentType: String? = nil
    ) throws -> URLRequest {
        let url = try makeURL(path: path, queryItems: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let contentType {
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        if requiresAuth {
            guard let userSecret else {
                throw APIError.notLoggedIn
            }
            // Adjust header name/format here if your backend expects something different.
            request.setValue("Bearer \(userSecret.uuidString)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = body
        return request
    }
    
    /// Generic helper to perform an authenticated request and decode the response.
    func performRequest<T: Decodable>(
        _ type: T.Type,
        path: String,
        method: String = "GET",
        requiresAuth: Bool = true,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        contentType: String? = "application/json"
    ) async throws -> T {
        let request = try makeRequest(
            path: path,
            method: method,
            requiresAuth: requiresAuth,
            queryItems: queryItems,
            body: body,
            contentType: contentType
        )
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badResponse(statusCode: -1)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            print("API error status: \(httpResponse.statusCode)")
            throw APIError.badResponse(statusCode: httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
    
    /// Convenience wrapper for simple GETs after login.
    func authedGet<T: Decodable>(
        _ type: T.Type,
        path: String,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> T {
        try await performRequest(
            type,
            path: path,
            method: "GET",
            requiresAuth: true,
            queryItems: queryItems,
            body: nil,
            contentType: nil
        )
    }
    
    /// Convenience wrapper for simple POSTs after login.
    func authedPost<T: Decodable, Body: Encodable>(
        _ type: T.Type,
        path: String,
        bodyObject: Body
    ) async throws -> T {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let bodyData = try encoder.encode(bodyObject)
        
        return try await performRequest(
            type,
            path: path,
            method: "POST",
            requiresAuth: true,
            queryItems: nil,
            body: bodyData,
            contentType: "application/json"
        )
    }
}
