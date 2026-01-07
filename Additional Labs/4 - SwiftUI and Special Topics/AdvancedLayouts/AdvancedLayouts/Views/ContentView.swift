//
//  ContentView.swift
//  AdvancedLayouts
//
//  Created by Ezra Pease on 1/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Section("Hats") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(hats, id: \.self) { hat in
                            ClothingCellView(clothing: hat, length: geometry.size.width)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
