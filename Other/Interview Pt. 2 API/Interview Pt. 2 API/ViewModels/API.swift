//
//  API.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//
import Foundation

@Observable
class API {
    var userAmount = 1
    
    func fetchUsers() async throws -> APIResponse {
        guard let url = URL(string: "https://randomuser.me/api/?results=\(userAmount)") else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
        
        let decoder = JSONDecoder()
        return try decoder.decode(APIResponse.self, from: data)
    }
}
