//
//  Transactions.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/22/26.
//

import Foundation

struct Transactions: Identifiable {
    var id = UUID()
    
    var amount: Double
    var timeStamp: Date = .now
}
