//
//  RepresentativeAPIControllerProtocol.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/25/25.
//

import SwiftUI


class RepresentativeAPIController: RepresenativeAPIControllerProtocol {
    func fetchUSARep(zip: String? = nil) async throws -> [USReps] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "whoismyrepresentative.com"
        components.path = "/getall_mems.php"
        
        let queryItems = [
            URLQueryItem(name: "zip", value: zip), // Zip value should = zip | Numbers in place indicate debugging
            URLQueryItem(name: "output", value: "json")
        ]
        
        components.queryItems = queryItems
        print("DEBUGING INFO LINK - \(components)")

        
        guard let url = components.url else { throw USRepErrors.unableToFetchREP }
        let (data, _) = try await URLSession.shared.data(from: url)
//        print(String(data: data, encoding: .utf8))
        
        let APIReps = try JSONDecoder().decode(USRepsResults.self, from: data)
        return APIReps.results
    }
}
