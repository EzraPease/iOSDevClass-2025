//
//  AddBudget:ExpenseView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/16/26.
//

import SwiftUI

struct UpdateBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: BudgetViewModel
    @State private var isNewCategory = false
    
    var body: some View {
        NavigationStack {
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
                                NewBudget()
                            } else {
                                ExistingBudget()
                            }
                            
                            Spacer()
                        }
                    }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        // TODO: Add Function
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UpdateBudgetView(viewModel: BudgetViewModel())
}
