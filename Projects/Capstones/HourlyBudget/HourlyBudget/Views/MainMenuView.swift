//
//  MainMenuView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI
import SwiftData

struct MainMenuView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    @Query private var expensesBudgets: [Budget]
    @Query private var savingsBudgets: [Budget]
    
    let savingsCategory = BudgetCategories.savings.rawValue
    let expensesCategory = BudgetCategories.expenses.rawValue
    
    private var totalExpenses: Double {
        expensesBudgets.reduce(0) { $0 + $1.currentValue }
    }
    private var totalSavings: Double {
        savingsBudgets.reduce(0) { $0 + $1.currentValue }
    }


    init(currentView: Binding<CurrentView>) {
        _currentView = currentView
        _expensesBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == expensesCategory
        }, sort: \Budget.categoryName)
    }
    
    var body: some View {
            VStack(spacing: 80) {
                Spacer()
                
                Group {
                    Group {
                        Button {
                            currentView = .savings
                        } label: {
                            VStack {
                                Text("View Savings")
                                Text(totalSavings, format: .currency(code: "USD"))
                                    .italic()
                            }
                            .foregroundStyle(.green)
                        }
                        Button {
                            currentView = .expenses
                        } label: {
                            VStack {
                                Text("View Expenses")
                                Text(totalExpenses, format: .currency(code: "USD"))
                                    .italic()
                            }
                            .foregroundStyle(.red)
                        }
                    }
                    .frame(width: 170)
                    
                    Button("View Budget") {
                        currentView = .budgetOverview
                    }
                }
                .padding()
                .glassEffect()
                .shadow(radius: 15)
                .font(.title3)
                .bold()
                
                Spacer()
            }
    }
}

#Preview {
    MainMenuView(currentView: .constant(.mainMenu))
        .environment(BudgetViewModel())
}
