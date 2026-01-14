//
//  BudgetCell.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct BudgetCell: View {
    @State var scale: CGFloat
    @State var currentValue: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 21)
            .fill(.cyan)
            .frame(width: scale, height: scale)
            .overlay {
                VStack {
                    Text("\(currentValue)")
                    Image(systemName: "photo")
                }
            }

    }
}
