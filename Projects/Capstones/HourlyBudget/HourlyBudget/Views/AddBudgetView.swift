//
//  AddBudget:ExpenseView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/16/26.
//

import SwiftUI
import SwiftData

struct AddBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(BudgetViewModel.self) var viewModel
    @State private var isNewCategory = false
    
    @State var budgetName = ""
    @State var startingAmount = "0"
    @State var selectedCategory: BudgetCategories = .savings
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.cyan)
                    .overlay {
                        VStack {
                            NewBudget(budgetName: $budgetName, startingAmount: $startingAmount, selectedCategory: $selectedCategory)

                            Spacer()
                        }
                    }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        // TODO: Add Function
                        if let amountAsDouble = Double(startingAmount) {
                            viewModel.budgetList.append(Budget(categoryName: budgetName, currentValue: amountAsDouble, setCategory: selectedCategory))
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddBudgetView()
        .environment(BudgetViewModel())
}
