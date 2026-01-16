//
//  ExpensesView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct ExpensesView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    var body: some View {
        VStack {
            Savings_Expenses(totalAmount: viewModel.expenses, setCategory: .expenses, viewModel: viewModel)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    currentView = .mainMenu
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#Preview {
    ExpensesView(currentView: .constant(.expenses))
        .environment(BudgetViewModel())
}
