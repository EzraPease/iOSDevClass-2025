//
//  BudgetList.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI
import Observation
import SwiftData

@Observable
class BudgetViewModel {
    // MARK: - Mock Data
    var budgetList: [Budget]
    
    init() {
        budgetList = [
            // Temporary Mock Values
            Budget(categoryName: "Emergency Fund", currentValue: 10032, setCategory: .savings, transactions: [Transactions(amount: 391, timeStamp: .now)]),
            Budget(categoryName: "Vacation Savings", currentValue: 1002, setCategory: .savings, transactions: [Transactions(amount: 250, timeStamp: .now),
                                                                                                               Transactions(amount: 150, timeStamp: .now.addingTimeInterval(-86400))]),
            Budget(categoryName: "Rent", currentValue: 47318, setCategory: .expenses, transactions: [Transactions(amount: 1200, timeStamp: .now)]),
            Budget(categoryName: "Car Payment", currentValue: 85731, setCategory: .expenses, transactions: [Transactions(amount: 450, timeStamp: .now),
                                                                                                            Transactions(amount: 450, timeStamp: .now.addingTimeInterval(-2592000))]),
            Budget(categoryName: "Utilities", currentValue: 43018, setCategory: .expenses, transactions: [Transactions(amount: 180, timeStamp: .now)]),
            Budget(categoryName: "Groceries", currentValue: 73508, setCategory: .expenses, transactions: [Transactions(amount: 85, timeStamp: .now),
                                                                                                          Transactions(amount: 120, timeStamp: .now.addingTimeInterval(-172800)), Transactions(amount: 95, timeStamp: .now.addingTimeInterval(-345600))]),
            Budget(categoryName: "Miscellaneous", currentValue: 82108, setCategory: .uncategorized, transactions: [Transactions(amount: 50, timeStamp: .now)]),
            Budget(categoryName: "Retirement", currentValue: 57308, setCategory: .savings, transactions: [Transactions(amount: 500, timeStamp: .now),
                                                                                                          Transactions(amount: 500, timeStamp: .now.addingTimeInterval(-604800))]),
            Budget(categoryName: "Insurance", currentValue: 487195, setCategory: .expenses, transactions: [Transactions(amount: 350, timeStamp: .now)]),
            Budget(categoryName: "House Down Payment", currentValue: 47193, setCategory: .savings, transactions: [Transactions(amount: 2000, timeStamp: .now),
                                                                                                                  Transactions(amount: 2000, timeStamp: .now.addingTimeInterval(-2592000))]),
            Budget(categoryName: "College Fund", currentValue: 97927, setCategory: .savings, transactions: [Transactions(amount: 300, timeStamp: .now)]),
            Budget(categoryName: "Subscriptions", currentValue: 10032, setCategory: .expenses, transactions: [Transactions(amount: 15, timeStamp: .now),
                                                                                                              Transactions(amount: 10, timeStamp: .now.addingTimeInterval(-2592000)), Transactions(amount: 20, timeStamp: .now.addingTimeInterval(-5184000))]),
            Budget(categoryName: "Emergency Buffer", currentValue: 1002, setCategory: .savings, transactions: [Transactions(amount: 100, timeStamp: .now)]),
            Budget(categoryName: "New Car Savings", currentValue: 47318, setCategory: .savings, transactions: [Transactions(amount: 500, timeStamp: .now),
                                                                                                               Transactions(amount: 500, timeStamp: .now.addingTimeInterval(-604800))]),
            Budget(categoryName: "Dining Out", currentValue: 85731, setCategory: .expenses, transactions: [Transactions(amount: 45, timeStamp: .now),
                                                                                                           Transactions(amount: 60, timeStamp: .now.addingTimeInterval(-172800)), Transactions(amount: 35, timeStamp: .now.addingTimeInterval(-345600)), Transactions(amount: 55, timeStamp: .now.addingTimeInterval(-518400))]),
            Budget(categoryName: "Home Maintenance Savings", currentValue: 43018, setCategory: .savings, transactions: [Transactions(amount: 200, timeStamp: .now)]),
            Budget(categoryName: "Gifts", currentValue: 73508, setCategory: .uncategorized, transactions: [Transactions(amount: 75, timeStamp: .now),
                                                                                                           Transactions(amount: 50, timeStamp: .now.addingTimeInterval(-604800))]),
            Budget(categoryName: "Short-Term Savings", currentValue: 82108, setCategory: .savings),
            Budget(categoryName: "Transportation", currentValue: 57308, setCategory: .expenses),
            Budget(categoryName: "Healthcare", currentValue: 487195, setCategory: .expenses),
            Budget(categoryName: "Debt Payment", currentValue: 47193, setCategory: .expenses),
            Budget(categoryName: "To Be Budgeted", currentValue: 97927, setCategory: .uncategorized)
        ]
    }
    // MARK: - Persitence Methods
    // Filtered Pinned Budgets
//    var pinnedBudget: [Budget] {
//        budgetList.filter { $0.isPinned }
//    }
//    
//    // Filtered Budgets Into Savings
//    var savingsBudget: [Budget] {
//        budgetList.filter { $0.setCategory == .savings && !$0.isPinned }
//    }
//    
//    // Filtered Budgets Into Expenses
//    var expenseBudget: [Budget] {
//        budgetList.filter { $0.setCategory == .expenses && !$0.isPinned }
//    }
    
    // Total Expenses
    var expenses: Double {
        budgetList.filter { $0.setCategory == .expenses }.reduce(0) { $0 + $1.currentValue }
    }
    
    // Total Savings
    var savings: Double {
        budgetList.filter { $0.setCategory == .savings }.reduce(0) { $0 + $1.currentValue }
    }
    
    // Total Left Uncategorized
    var uncategorized: Double {
        budgetList.filter { $0.setCategory == .uncategorized }.reduce(0) { $0 + $1.currentValue }
    }
    
    // MARK: - Functions
    func pin(_ budget: Budget, context: ModelContext) {
        budget.isPinned = true
        try? context.save()
    }

    func delete(_ budget: Budget, context: ModelContext) {
        context.delete(budget)
        try? context.save()
    }
    
    func save(_ budget: Budget, context: ModelContext) {
        context.insert(budget)
        try? context.save()
    }
}
