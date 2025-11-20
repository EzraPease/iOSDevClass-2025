//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Jane Madsen on 11/3/25.
//

import SwiftUI

@Observable
class StoreItemListViewModel {
    let itemController = StoreItemController()
    var items: [StoreItem] = []
    
    var searchText = ""
    var selectedMediaType: MediaType = .music
    var query: [String: String] = [:]
    
    var previewTask: Task<Void, Never>? = nil
    
    func fetchPreview(item: StoreItem) {
        if let previewTask {
            previewTask.cancel()
            self.previewTask = nil
        }

        previewTask = Task {
            if let previewURL = item.previewURL {
                do {
                    let data = try await itemController.fetchPreview(from: previewURL)
                } catch {
                    print(error)
                }
            } else {
                previewTask = nil
            }
        }
    }
    
    func fetchMatchingItems() {
        if !searchText.isEmpty {
            // set up query dictionary
            query = [
                "term": searchText,
                "media": selectedMediaType.rawValue,
                "limit": "50",
                "lang": Locale.current.identifier,
                "country": Locale.current.region?.identifier ?? "US"
            ]
            
            // use the item controller to fetch items
            // if successful, use the main queue to set self.items
            // otherwise, print an error to the console
            Task {
                do {
                    let controller = StoreItemController()
                    let results = try await controller.fetchItems(matching: query)
                    await MainActor.run {
                        self.items = results
                    }
                } catch {
                    print("Failed to fetch items: \(error)")
                }
            }
        }
    }
}

struct StoreItemListView: View {
    @State private var viewModel = StoreItemListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Media Type", selection: $viewModel.selectedMediaType) {
                    ForEach(MediaType.allCases, id: \.self) { mediaType in
                        Text(mediaType.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal, .top])
                
                HStack {
                    TextField("Search...", text: $viewModel.searchText) {
                        viewModel.fetchMatchingItems()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        viewModel.fetchMatchingItems()
                    }
                    .submitLabel(.search)
                    .padding([.horizontal, .bottom])
                }
                
                List(viewModel.items, id: \.self) { item in
                    ItemCellView(storeItem: item, onPlayButtonPressed: { viewModel.fetchMatchingItems() })
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("iTunes Search")
            .onAppear {
                viewModel.fetchMatchingItems()
            }
        }
    }
}

#Preview {
    StoreItemListView()
}
