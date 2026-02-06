//
//  CurrentUserViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI
import Observation

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
    
    func fetchCurrentUser() async {
        // Fetch the latest profile for the logged in user from `/user/:userID`
        guard let secret = userSecret,
              let userId = currentUser?.userUUID else {
            return
        }
        
        struct Body: Codable {
            let userSecret: UUID
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let body = Body(userSecret: secret)
            let data = try encoder.encode(body)
            let path = "user/\(userId.uuidString)"
            
            let profile: CurrentUser = try await performRequest(
                CurrentUser.self,
                path: path,
                method: "GET",
                requiresAuth: false,
                queryItems: nil,
                body: data,
                contentType: "application/json"
            )
            
            currentUser = profile
            userPosts = profile.posts
            recentPost = profile.posts.last
        } catch {
            print("Error fetching current user profile: \(error)")
        }
    }
    
//     GET
    func getAPIRequest() async throws {
        do {
            // Simple connectivity test to `/auth/test`
            let url = baseURL.appendingPathComponent("auth/test")
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
            let session = URLSession.shared
        
            _ = try await session.data(for: request)
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
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("Bearer \(userSecret)", forHTTPHeaderField: "Authorization")
            
            let encoder = JSONEncoder()
            let body = LoginInput(email: email, password: password)
            request.httpBody = try encoder.encode(body)
            
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
    
    /// Builds a URLRequest for JSON APIs.
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
            requiresAuth: false,
            queryItems: nil,
            body: bodyData,
            contentType: "application/json"
        )
    }

    // MARK: - Social Media User Routes
    
    func updateProfile(userName: String, bio: String?, techInterests: String?) async throws {
        guard let secret = userSecret else { throw APIError.notLoggedIn }
        
        struct ProfileBody: Codable {
            struct Profile: Codable {
                let userName: String
                let bio: String?
                let techInterests: String?
            }
            let userSecret: UUID
            let profile: Profile
        }
        
        let body = ProfileBody(
            userSecret: secret,
            profile: .init(userName: userName,
                           bio: bio,
                           techInterests: techInterests)
        )
        
        let updated: CurrentUser = try await authedPost(
            CurrentUser.self,
            path: "user/update-profile",
            bodyObject: body
        )
        
        currentUser = updated
        userPosts = updated.posts
        recentPost = updated.posts.last
    }
    
    // MARK: - Social Media Post Routes
    
    func fetchTimelinePosts(page: Int? = nil) async throws -> [Post] {
        guard let secret = userSecret else { throw APIError.notLoggedIn }
        
        struct Body: Codable {
            let userSecret: UUID
        }
        
        let body = Body(userSecret: secret)
        
        let path: String
        if let page {
            path = "posts/\(page)"
        } else {
            path = "posts"
        }
        
        let posts: [Post] = try await performRequest(
            [Post].self,
            path: path,
            method: "GET",
            requiresAuth: false,
            queryItems: nil,
            body: try JSONEncoder().encode(body),
            contentType: "application/json"
        )
        
        return posts
    }
    
    func createPost(title: String, bodyText: String) async throws -> Post {
        guard let secret = userSecret else { throw APIError.notLoggedIn }
        
        struct CreatePostBody: Codable {
            struct PostPayload: Codable {
                let title: String
                let body: String
            }
            let userSecret: UUID
            let post: PostPayload
        }
        
        let body = CreatePostBody(
            userSecret: secret,
            post: .init(title: title, body: bodyText)
        )
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(body)
        
        let post: Post = try await performRequest(
            Post.self,
            path: "post",
            method: "POST",
            requiresAuth: false,
            queryItems: nil,
            body: data,
            contentType: "application/json"
        )
        
        return post
    }
    
    func updatePost(postID: UUID, title: String, bodyText: String) async throws -> Post {
        guard let secret = userSecret else { throw APIError.notLoggedIn }
        
        struct EditPostBody: Codable {
            struct PostPayload: Codable {
                let title: String
                let body: String
            }
            let userSecret: UUID
            let post: PostPayload
        }
        
        let body = EditPostBody(
            userSecret: secret,
            post: .init(title: title, body: bodyText)
        )
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(body)
        
        let path = "post/edit/\(postID.uuidString)"
        
        let post: Post = try await performRequest(
            Post.self,
            path: path,
            method: "POST",
            requiresAuth: false,
            queryItems: nil,
            body: data,
            contentType: "application/json"
        )
        
        return post
    }
    
    func deletePost(postID: UUID) async throws {
        guard let secret = userSecret else { throw APIError.notLoggedIn }
        
        struct DeleteBody: Codable {
            let userSecret: UUID
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let body = try encoder.encode(DeleteBody(userSecret: secret))
        
        let path = "post/\(postID.uuidString)"
        let request = try makeRequest(
            path: path,
            method: "DELETE",
            requiresAuth: false,
            queryItems: nil,
            body: body,
            contentType: "application/json"
        )
        
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            throw APIError.badResponse(statusCode: httpResponse.statusCode)
        }
    }
}
