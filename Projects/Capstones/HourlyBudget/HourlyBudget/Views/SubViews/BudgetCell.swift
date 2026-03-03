//
//  BudgetCell.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct BudgetCell: View {
    @State var scale: CGFloat
    @State var budget: Budget
    
    var body: some View {
        VStack {
            Text(budget.categoryName)
                .font(.title3)
                .bold()
                .foregroundStyle(Color.text)
            Text(budget.currentValue, format: .currency(code: "USD"))
                .foregroundStyle(Color.text)
            Image(systemName: "photo")
                .foregroundStyle(Color.neutralState)
        }
        .frame(width: scale, height: scale)
        .background {
            RoundedRectangle(cornerRadius: 21)
                .fill(.white)
        }
    }
}


#Preview {
    ContentView()
}
