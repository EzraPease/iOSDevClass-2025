//
//  EditView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 2/16/26.
//

import SwiftUI

struct EditView: View {
    @State var budgetName: String
    @State var budgetValue: String
    
    var body: some View {
        
        VStack {
        // TODO: Set up the category name and value to work correctly
            TextField("Budget Name", text: $budget.categoryName)
            TextField("Budget Amount", text: $value)
        }
    }
}

#Preview {
    EditView(budgetName: "Example Budget", budgetValue: 1841.48)
}
