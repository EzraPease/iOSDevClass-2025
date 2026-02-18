//
//  EditView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 2/16/26.
//

import SwiftUI
import SwiftData

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var budget: Budget
    
    var body: some View {
        List {
            Section("Budget Name") {
                TextField("Budget Name", text: $budget.categoryName)
            }
            Section("Budget Amount") {
                TextField("Budget Amount", value: $budget.currentValue, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    save()
                }
            }
        }
    }
    // TODO: Fix save funcion
    private func save() {
        try? context.save()
        dismiss()
    }
}

#Preview {
    EditView(budget: Budget(categoryName: "Example Category", currentValue: 37141.415))
}
