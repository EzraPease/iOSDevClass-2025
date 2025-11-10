//
//  StoreitemViewModel.swift
//  iTunesSearch
//
//  Created by Ezra Pease on 11/10/25.
//

import Foundation
import SwiftUI

@Observable
class StoreItemListViewModel {
    var items: [StoreItem] = []
    
    func fetchItems(searchText: String, mediaTypeIndex: Int) async {
        // Map mediaTypeIndex to the API string ("movie", "music", "software", "ebook") and perform network fetch.
        // On completion, update items on main queue.
        // For this template, leave as a stub.
        let baseURL = "https://itunes.apple.com/search"
        let query: [String: String] = [
            "term": searchText,
            "media": "audiobook"
        ]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else { return }
        
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
            let searchResponse = try decoder.decode(SearchResponse.self, from: data)
            items = searchResponse.results
            return searchResponse.results

        }
    }
}

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to read JSON Object.")
            return
        }
        print(prettyJSONString)
    }
}
