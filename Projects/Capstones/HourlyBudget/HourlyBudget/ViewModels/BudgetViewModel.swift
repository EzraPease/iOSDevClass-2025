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
            Budget(categoryName: "Emergency Fund", currentValue: 10032, setCategory: .savings),
            Budget(categoryName: "Vacation Savings", currentValue: 1002, setCategory: .savings),
            Budget(categoryName: "Rent", currentValue: 47318, setCategory: .expenses),
            Budget(categoryName: "Car Payment", currentValue: 85731, setCategory: .expenses),
            Budget(categoryName: "Utilities", currentValue: 43018, setCategory: .expenses),
            Budget(categoryName: "Groceries", currentValue: 73508, setCategory: .expenses),
            Budget(categoryName: "Miscellaneous", currentValue: 82108, setCategory: .uncategorized),
            Budget(categoryName: "Retirement", currentValue: 57308, setCategory: .savings),
            Budget(categoryName: "Insurance", currentValue: 487195, setCategory: .expenses),
            Budget(categoryName: "House Down Payment", currentValue: 47193, setCategory: .savings),
            Budget(categoryName: "College Fund", currentValue: 97927, setCategory: .savings),
            Budget(categoryName: "Subscriptions", currentValue: 10032, setCategory: .expenses),
            Budget(categoryName: "Emergency Buffer", currentValue: 1002, setCategory: .savings),
            Budget(categoryName: "New Car Savings", currentValue: 47318, setCategory: .savings),
            Budget(categoryName: "Dining Out", currentValue: 85731, setCategory: .expenses),
            Budget(categoryName: "Home Maintenance Savings", currentValue: 43018, setCategory: .savings),
            Budget(categoryName: "Gifts", currentValue: 73508, setCategory: .uncategorized),
            Budget(categoryName: "Short-Term Savings", currentValue: 82108, setCategory: .savings),
            Budget(categoryName: "Transportation", currentValue: 57308, setCategory: .expenses),
            Budget(categoryName: "Healthcare", currentValue: 487195, setCategory: .expenses),
            Budget(categoryName: "Debt Payment", currentValue: 47193, setCategory: .expenses),
            Budget(categoryName: "To Be Budgeted", currentValue: 97927, setCategory: .uncategorized)
        ]
    }
    
    // Filtered Budgets Into Savings
    var savingsBudget: [Budget] {
        var result: [Budget] = []
        for saving in budgetList {
            if saving.setCategory == .savings {
                result.append(saving)
            }
        }
        return result
    }
    
    // Filtered Budgets Into Expenses
    var expenseBudget: [Budget] {
        var result: [Budget] = []
        for expense in budgetList {
            if expense.setCategory == .expenses {
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
