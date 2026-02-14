//
//  ExpensesView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    @Query private var expensesBudgets: [Budget]
    
    let expensesCategory = BudgetCategories.expenses.rawValue
    private var totalExpenses: Double {
        expensesBudgets.reduce(0) { $0 + $1.currentValue }
    }


    init(currentView: Binding<CurrentView>) {
        _currentView = currentView
        _expensesBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == expensesCategory
        }, sort: \Budget.categoryName)
    }
    
    var body: some View {
        VStack {
            Savings_Expenses(totalAmount: totalExpenses, setCategory: .expenses)
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
    ExpensesView(currentView: .constant(.expenses))
        .environment(BudgetViewModel())
}
