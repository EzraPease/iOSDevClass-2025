//
//  BudgetList.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

@Observable
class BudgetViewModel {
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
    
    // Filtered Pinned Budgets
    var pinnedBudget: [Budget] {
        var result: [Budget] = []
        for pinned in budgetList {
            if pinned.isPinned {
                result.append(pinned)
            }
        }
        return result
    }
    
    // Filtered Budgets Into Savings
    var savingsBudget: [Budget] {
        var result: [Budget] = []
        for saving in budgetList {
            if saving.setCategory == .savings && !saving.isPinned {
                result.append(saving)
            }
        }
        return result
    }
    
    // Filtered Budgets Into Expenses
    var expenseBudget: [Budget] {
        var result: [Budget] = []
        for expense in budgetList {
            if expense.setCategory == .expenses && !expense.isPinned {
                result.append(expense)
            }
        }
        return result
    }
    
    // Total Expenses
    var expenses: Double {
        var result: Double = 0.0
        for budgetAmount in budgetList {
            if budgetAmount.setCategory == .expenses {
                result += budgetAmount.currentValue
            }
        }
        return result
    }
    
    // Total Savings
    var savings: Double {
        var result: Double = 0.0
        for budgetAmount in budgetList {
            if budgetAmount.setCategory == .savings {
                result += budgetAmount.currentValue
            }
        }
        return result
    }
    
    // Total Left Uncategorized
    var uncategorized: Double {
        var result: Double = 0.0
        for budgetAmount in budgetList {
            if budgetAmount.setCategory == .uncategorized {
                result += budgetAmount.currentValue
            }
        }
        return result
    }
}
