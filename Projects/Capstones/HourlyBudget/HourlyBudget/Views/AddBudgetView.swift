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
    @Environment(\.modelContext) private var context
    
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
                        do {
                            try saveNewBudget()
                        } catch {
                            print("ERROR - \(error): Failed to save new budget")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    func saveNewBudget() throws {
        if let amountAsDouble = Double(startingAmount) {
            guard !budgetName.isEmpty else { throw NewBudgetErrors.incompleteData }
            let budget = Budget(categoryName: budgetName, currentValue: amountAsDouble, setCategory: selectedCategory)
                 viewModel.save(budget, context: context)
            dismiss()
        } else {
            throw NewBudgetErrors.invalidValue
        }
    }
}

#Preview {
    AddBudgetView()
        .environment(BudgetViewModel())
}
