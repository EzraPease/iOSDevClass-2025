//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Ezra Pease on 11/14/25.
//

import SwiftUI

class StoreItemController {
    
    enum Errors: LocalizedError {
        case unableToFindURLComponents
    }
    
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        let baseURL = "https://itunes.apple.com/search"
        
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else { throw Errors.unableToFindURLComponents }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        return searchResponse.results
    }
}
