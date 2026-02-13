//
//  Budget.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import Foundation
import SwiftData

@Model
class Budget {
    var categoryName: String
    var currentValue: Double
    var setCategory: BudgetCategories {
        get { BudgetCategories(rawValue: _setCategory)! }
        set { _setCategory = newValue.rawValue }
    }
    var isPinned: Bool = false
    @Relationship(deleteRule: .cascade, inverse: \Transactions.budget) var transactions: [Transactions] = []
    var _setCategory: String
    
    init(
        categoryName: String,
        currentValue: Double,
        setCategory: BudgetCategories = .uncategorized,
        transactions: [Transactions] = []
    ) {
        self.categoryName = categoryName
        self.currentValue = currentValue
        self._setCategory = setCategory.rawValue
        self.transactions = transactions
    }
}

