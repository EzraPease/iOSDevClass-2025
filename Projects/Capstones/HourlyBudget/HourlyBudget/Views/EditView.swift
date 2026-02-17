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
    @State var budgetName: String
    @State var budgetValue: String
    
    var body: some View {
        List {
            Section("Budget Name") {
                TextField("Budget Name", text: $budgetName)
            }
            Section("Budget Amount") {
                TextField("Budget Amount", text: $budgetValue)
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
    EditView(budgetName: "Example Budget", budgetValue: "1841.48")
}
