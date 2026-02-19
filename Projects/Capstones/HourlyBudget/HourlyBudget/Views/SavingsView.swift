//
//  SavingsView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI
import SwiftData

struct SavingsView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    @Query private var savingsBudgets: [Budget]
    
    let savingsCategory = BudgetCategories.savings.rawValue
    private var totalSavings: Double {
        savingsBudgets.reduce(0) { $0 + $1.currentValue }
    }
    
    init(currentView: Binding<CurrentView>) {
        self._currentView = currentView
        _savingsBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == savingsCategory
        }, sort: \Budget.categoryName)
    }

    
    var body: some View {
        VStack {
            // TODO: Fix totalAmount to sow the amount from SwiftData in this view and ExpensesView
            Savings_Expenses(setCategory: .savings)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    currentView = .mainMenu
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#Preview {
    SavingsView(currentView: .constant(.savings))
        .environment(BudgetViewModel())
}
