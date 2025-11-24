//
//  DogDetailView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


struct DogDetailView: View {
    @Binding var currentDog: DogListCell
    
    var body: some View {
        TextField(currentDog.name, text: $currentDog.name)
    }
}
