//
//  NewPostView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/12/25.
//

import SwiftUI



struct NewPostViewModel: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var titleText = ""
    @State private var descriptionText = ""
    @State private var imageURL = ""
    
    var body: some View {
            List {
                Section {
                    TextField("Title", text: $titleText)
                    TextField("Description", text: $descriptionText)
                }
                Section {
                    TextField("Image URL", text: $imageURL)
                }
            }
        .navigationTitle("New Post")
        .navigationBarTitleDisplayMode(.inline)
        Button("Submit") {
            print("Submit Button Pressed")
            dismiss()
        }
        .padding()
        .glassEffect()
    }
}


#Preview {
    NewPostViewModel()
}
