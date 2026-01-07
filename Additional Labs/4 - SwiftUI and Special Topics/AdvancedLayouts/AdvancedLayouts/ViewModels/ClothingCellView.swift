//
//  ClothingCellViewModel.swift
//  AdvancedLayouts
//
//  Created by Ezra Pease on 1/7/26.
//

import SwiftUI

struct ClothingCell {
    var clothingItem: Clothing
    var length: CGFloat
}

struct ClothingCellView: View {
    var clothing: Clothing
    var length: CGFloat
    
    var body: some View {
        VStack {
            Text(clothing.name)
            Text("\(clothing.price)")
            Text(clothing.color)
                .font(.footnote)
                .foregroundStyle(.gray)
        }
    }
}
