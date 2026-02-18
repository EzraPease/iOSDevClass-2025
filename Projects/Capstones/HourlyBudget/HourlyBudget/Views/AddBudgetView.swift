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
    @State var value: Double = 0.00
    @State var selectedCategory: BudgetCategories = .savings
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    NewBudget(budgetName: $budgetName, startingAmount: $value, selectedCategory: $selectedCategory)

                    Spacer()
                }
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button("Save") {
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
            guard !budgetName.isEmpty else { throw NewBudgetErrors.incompleteData }
            let budget = Budget(categoryName: budgetName, currentValue: value, setCategory: selectedCategory)
                 viewModel.save(budget, context: context)
            dismiss()
    }
}

#Preview {
    AddBudgetView()
        .environment(BudgetViewModel())
}
