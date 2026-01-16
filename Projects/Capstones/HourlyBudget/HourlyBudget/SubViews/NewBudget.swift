//
//  NewBudget.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/16/26.
//

import SwiftUI

struct NewBudget: View {
    @State private var budgetName = ""
    @State private var startingAmount = "0"
    @State private var selectedCategory: BudgetCategories = .savings
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section("Budget Name") {
                    TextField("Budget name...", text: $budgetName)
                }
                Section("Starting Amount") {
                    TextField("Starting amount...", text: $startingAmount)
                        .keyboardType(.numberPad)
                }
                Section("Choose a Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(BudgetCategories.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .shadow(radius: 10)
    }
}

#Preview {
    NewBudget()
}
