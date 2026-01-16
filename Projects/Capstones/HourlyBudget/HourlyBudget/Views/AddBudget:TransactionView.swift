//
//  AddBudget:ExpenseView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/16/26.
//

import SwiftUI

struct AddBudget_TransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: BudgetViewModel
    @State private var isNewCategory = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.cyan)
                .overlay {
                    VStack {
                        Toggle(isOn: $isNewCategory) {
                            Text("New Budget")
                        }
                        .padding()
                        .glassEffect()
                        .padding()
                        if isNewCategory {
                            Text("New Category")
                        } else {
                            Text("Existing Category")
                        }
                    }
                }
        }
        .padding()
    }
}

#Preview {
    AddBudget_TransactionView(viewModel: BudgetViewModel())
}
