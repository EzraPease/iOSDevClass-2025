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
            "term": "taylor swift",
            "media": "music"
        ]

        var components = URLComponents(string: baseURL)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else { return }
        
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let stringData = String(data: data, encoding: .utf8) {
                print(stringData)
            }
        }
    }
}



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
