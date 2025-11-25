//
//  DogDetailView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


struct DogDetailView: View {
    @Environment(DogListViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    @State private var dogName: String
    var currentDog: DogListCell
    
    init(currentDog: DogListCell) {
        self.currentDog = currentDog
        self.dogName = currentDog.name
    }
    
    var body: some View {
        List {
            TextField(currentDog.name, text: $dogName)
        }
        Button("Save") {
            if let index = viewModel.dogList.firstIndex(of: currentDog) {
                viewModel.dogList[index] = DogListCell(id: currentDog.id, image: currentDog.image, name: dogName)
                dismiss()
            }
        }
    }
}
#Preview {
    ParentView()
}
