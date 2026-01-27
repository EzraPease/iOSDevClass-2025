//
//  Transactions.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/22/26.
//

import Foundation
import SwiftData

@Model
class Transactions: Identifiable {
    var amount: Double
    var timeStamp: Date
    var note: String?
    var budget: Budget? // many-to-one inverse

    init(amount: Double, timeStamp: Date = .now, note: String? = nil, budget: Budget? = nil) {
        self.amount = amount
        self.timeStamp = timeStamp
        self.note = note
        self.budget = budget
    }
}
