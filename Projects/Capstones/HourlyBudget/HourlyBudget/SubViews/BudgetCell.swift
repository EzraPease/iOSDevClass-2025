//
//  BudgetCell.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct BudgetCell: View {
    @State var scale: CGFloat
    @State var currentValue: Double
    @State var categoryName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 21)
            .fill(.cyan)
            .frame(width: scale, height: scale)
            .overlay {
                VStack {
                    Text(categoryName)
                        .font(.title3)
                        .bold()
                    Text(currentValue, format: .currency(code: "USD"))
                    Image(systemName: "photo")
                }
            }

    }
}


#Preview {
    ContentView()
}
