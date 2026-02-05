//
//  BudgetCatagories.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/15/26.
//

import Foundation


enum BudgetCategories: String, CaseIterable, Codable {
    case savings = "Savings"
    case expenses = "Expenses"
    case uncategorized = "No Category"
}
