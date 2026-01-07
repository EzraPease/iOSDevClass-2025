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
                Section(header: Text("Hats").font(.title2).bold().underline()) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(hats, id: \.self) { hat in
                                ClothingCellView(clothing: hat, length: geometry.size.width)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(3)
                    }
                    .scrollTargetBehavior(.viewAligned)
                }
                
                Spacer(minLength: 80)
                
                Section(header: Text("Shirts").font(.title2).bold().underline()) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(
                            rows: [
                                GridItem(.fixed(geometry.size.width - 290), spacing: 16),
                                GridItem(.fixed(geometry.size.width - 290), spacing: 16)
                            ]
                        ) {
                            ForEach(shirts, id: \.self) { shirt in
                                ClothingCellView(clothing: shirt, length: geometry.size.width)
                            }
                        }
                    }
                }
                
                Spacer(minLength: 80)
                
                Section(header: Text("Pants").font(.title2).bold().underline()) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(
                            rows: [
                                GridItem(.adaptive(minimum: (geometry.size.width - 290), maximum: .infinity), spacing: 16),
                                GridItem(.adaptive(minimum: (geometry.size.width - 290), maximum: .infinity), spacing: 16),
                                GridItem(.adaptive(minimum: (geometry.size.width - 290), maximum: .infinity), spacing: 16),
                                GridItem(.adaptive(minimum: (geometry.size.width - 290), maximum: .infinity), spacing: 16)
                            ]
                        ) {
                            ForEach(pants, id: \.self) { pant in
                                ClothingCellView(clothing: pant, length: geometry.size.width)
                            }
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
