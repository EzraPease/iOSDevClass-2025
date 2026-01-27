//
//  Budget.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import Foundation
import SwiftData

@Model
class Budget: Identifiable {
    var categoryName: String
    var currentValue: Double
    var setCategory: BudgetCategories
    var isPinned: Bool = false
    
    @Relationship(inverse: \Transactions.budget) var transactions: [Transactions] = []
//    var transactions: [Transactions] = []
    
    init(categoryName: String, currentValue: Double, setCategory: BudgetCategories = .uncategorized, isPinned: Bool, transactions: [Transactions]) {
        self.categoryName = categoryName
        self.currentValue = currentValue
        self.setCategory = setCategory
        self.isPinned = isPinned
        self.transactions = transactions
    }
}

