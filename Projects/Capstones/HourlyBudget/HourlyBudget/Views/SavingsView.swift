//
//  SavingsView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct SavingsView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    var body: some View {
        VStack {
            Savings_Expenses(totalAmount: viewModel.savings, setCategory: .savings, viewModel: viewModel)
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
    SavingsView(currentView: .constant(.savings))
        .environment(BudgetViewModel())
}
