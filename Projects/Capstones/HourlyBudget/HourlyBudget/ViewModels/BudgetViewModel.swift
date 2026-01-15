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
            Budget(currentValue: 10032, setCatagory: .savings),
            Budget(currentValue: 1002, setCatagory: .savings),
            Budget(currentValue: 47318, setCatagory: .expenses),
            Budget(currentValue: 85731, setCatagory: .expenses),
            Budget(currentValue: 43018, setCatagory: .expenses),
            Budget(currentValue: 73508, setCatagory: .expenses),
            Budget(currentValue: 82108),
            Budget(currentValue: 57308, setCatagory: .savings),
            Budget(currentValue: 487195, setCatagory: .expenses),
            Budget(currentValue: 47193, setCatagory: .savings),
            Budget(currentValue: 97927, setCatagory: .savings),
            Budget(currentValue: 10032, setCatagory: .expenses),
            Budget(currentValue: 1002, setCatagory: .savings),
            Budget(currentValue: 47318, setCatagory: .savings),
            Budget(currentValue: 85731, setCatagory: .expenses),
            Budget(currentValue: 43018, setCatagory: .savings),
            Budget(currentValue: 73508),
            Budget(currentValue: 82108, setCatagory: .savings),
            Budget(currentValue: 57308, setCatagory: .expenses),
            Budget(currentValue: 487195, setCatagory: .expenses),
            Budget(currentValue: 47193, setCatagory: .expenses),
            Budget(currentValue: 97927)
        ]
    }
    
    var expenses: Double {
        var result: Double = 0.0
        for budgetAmount in budgetList {
            if budgetAmount.setCatagory == .expenses {
                result += Double(budgetAmount.currentValue)
            }
        }
        return result
    }
    
    var savings: Double {
        var result: Double = 0.0
        for budgetAmount in budgetList {
            if budgetAmount.setCatagory == .savings {
                result += Double(budgetAmount.currentValue)
            }
        }
        return result
    }
}
