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
    
    var searchText = ""
    var selectedMediaType: MediaType = .music
    
    func fetchMatchingItems() {
        if !searchText.isEmpty {
            // set up query dictionary
            
            // use the item controller to fetch items
            // if successful, use the main queue to set self.items
            // otherwise, print an error to the console
            Task {
                do {
                    let controller = StoreItemController()
                    let results = try await controller.fetchItems(searchText: searchText, mediaTypeIndex: selectedMediaType)
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
                    .submitLabel(.search)
                    .padding([.horizontal, .bottom])
                }
                
                List(viewModel.items, id: \.self) { item in
                    ItemCellView(name: item.trackName, artist: item.artistName)
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
