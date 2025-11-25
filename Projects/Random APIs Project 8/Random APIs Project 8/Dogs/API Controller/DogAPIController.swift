//
//  DogAPIController.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


@Observable
class DogAPIController: DogAPIControllerProtocol {
    
    
    
    func fetchDogImage() async throws -> String {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { throw DogErrors.unableToFetchURL }
        let (data, _) = try await URLSession.shared.data(from: url)
//        print(String(data: data, encoding: .utf8))
        
        let dogAPI = try JSONDecoder().decode(Dogs.self, from: data)
        return dogAPI.message
    }
    
    
}
