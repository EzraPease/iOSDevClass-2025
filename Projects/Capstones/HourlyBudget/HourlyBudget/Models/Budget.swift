//
//  Budget.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import Foundation


struct Budget: Identifiable {
    var id = UUID()
    
    var currentValue: Double
    var setCatagory: BudgetCatagories = .uncategorized
}

