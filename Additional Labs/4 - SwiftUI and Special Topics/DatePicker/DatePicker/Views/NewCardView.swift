//
//  NewCardView.swift
//  DatePicker
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI
import PhotosUI

struct NewCardView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var description = ""
    @State private var date = Date()
    @State private var color: Color = .white
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data? = nil
    @State var viewModel: CardListViewModel
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Description") {
                        TextEditor(text: $description)
                            .frame(height: 150)
                    }
                    Section("Date") {
                        DatePicker("Select Day and Time", selection: $date)
                    }
                    Section("Background Color") {
                        ColorPicker("Pick a Color", selection: $color)
                    }
                    Section("Photo Theme") {
                        PhotosPicker("Pick a Photo", selection: $selectedPhoto, matching: PHPickerFilter.images)
                            .onChange(of: selectedPhoto) { _, newValue in
                                Task {
                                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    } else {
                                        selectedPhoto = nil
                                    }
                                }
                            }
                        
                        if let data = selectedImageData, let uiImage = UIImage(data: data) {
                           Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipped()
                                .cornerRadius(8)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
            }
            .navigationTitle("New Card")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveCard()
                    }
                }
            }
        }
    }
    
    private func saveCard() {
        // Build optional Image from selected image data
        let image: Image? = {
            if let data = selectedImageData, let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
            return Image(systemName: "photo")
        }()

        // Safely convert SwiftUI Color to CGColor on iOS
//        let cgColor: CGColor = UIColor(color).cgColor

        let newCard = Cards(description: description, date: date, color: color, photo: image!)
        
        viewModel.cardList.append(newCard)
        dismiss()
        
        print("New Card Saved")
        print(viewModel.cardList.count)
    }
}

#Preview {
    NewCardView(viewModel: CardListViewModel())
}
