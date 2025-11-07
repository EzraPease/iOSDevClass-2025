//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//

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
            "term": "Apple",
            "media": "audiobook"
        ]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else { return }
        
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
                data.prettyPrintedJSONString()
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

//Task {
//    let (data, response) = try await       URLSession.shared.data(from: urlComponents.url!)
//
//    if let httpResponse = response as? HTTPURLResponse,
//       httpResponse.statusCode == 200 {        data.prettyPrintedJSONString()
//    }
//}


struct StoreItemListView: View {
    @State private var viewModel = StoreItemListViewModel()
    @State private var searchText = ""
    @State private var selectedMediaType = 0
    
    let mediaTypes = ["Movies", "Music", "Apps", "Books"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Media Type", selection: $selectedMediaType) {
                    ForEach(0..<mediaTypes.count, id: \.self) { index in
                        Text(mediaTypes[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal, .top])
                
                TextField("Search...", text: $searchText, onCommit: {
                    Task { await viewModel.fetchItems(searchText: searchText, mediaTypeIndex: selectedMediaType) }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal, .bottom])
                
                List(viewModel.items) { item in
                    ItemCellView(item: item)
                }
                .listStyle(.plain)
            }
            .navigationTitle("iTunes Search")
            .onAppear {
                Task { await viewModel.fetchItems(searchText: searchText, mediaTypeIndex: selectedMediaType) }
            }
        }
    }
}

#Preview {
    StoreItemListView()
}
