//
//  DetailView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct DetailView: View {
    @Environment(BudgetViewModel.self) var viewModel
    let budget: Budget
    let scale: CGFloat
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center) {
                Details(
                    scale: scale,
                    currentValue: budget.currentValue,
                    defaultCategoryName: budget.categoryName
                )
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    // Scale 402 for iPhone 17 Pro
    DetailView(
        budget: Budget(categoryName: "Example Category", currentValue: 48281, setCategory: .savings),
        scale: 720.666
    )
    .environment(BudgetViewModel())
}
