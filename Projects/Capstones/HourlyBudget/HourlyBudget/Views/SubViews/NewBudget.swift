//
//  NewBudget.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/16/26.
//

import SwiftUI

struct NewBudget: View {
    @Binding var budgetName: String
    @Binding var startingAmount: Double
    @Binding var selectedCategory: BudgetCategories
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section("Budget Name") {
                    TextField("Budget name...", text: $budgetName)
                }
                Section("Starting Amount") {
                    TextField("Starting amount...", value: $startingAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                }
                Section("Choose a Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(BudgetCategories.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .shadow(radius: 10)
    }
}

#Preview {
    NewBudget(
        budgetName: .constant("Sample Budget"),
        startingAmount: .constant(100),
        selectedCategory: .constant(BudgetCategories.allCases.first ?? .savings)
    )
}
