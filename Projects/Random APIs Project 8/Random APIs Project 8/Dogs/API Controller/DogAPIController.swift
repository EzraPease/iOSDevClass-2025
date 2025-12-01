//
//  DogAPIController.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


@Observable
class DogAPIController: DogAPIControllerProtocol {
    
    
    func fetchDog() async throws -> Dog {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { throw DogErrors.unableToFetchURL }
        let (data, _) = try await URLSession.shared.data(from: url)
//        print(String(data: data, encoding: .utf8))
        
        return try JSONDecoder().decode(Dog.self, from: data)
    }
    
}
