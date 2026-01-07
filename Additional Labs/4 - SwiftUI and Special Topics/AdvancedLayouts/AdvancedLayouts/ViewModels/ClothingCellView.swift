//
//  ClothingCellViewModel.swift
//  AdvancedLayouts
//
//  Created by Ezra Pease on 1/7/26.
//

import SwiftUI

struct ClothingCellView: View {
    var clothing: Clothing
    var length: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.random())
            .frame(width: length - 290, height: length - 290)
            .overlay {
                VStack {
                    Text(clothing.name)
                        .bold()
                    Text("$\(String(format: "%.2f", clothing.price))")
                    Text(clothing.color)
                        .font(.footnote)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 3)
            }
    }
}
