//
//  ExpensesView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct ExpensesView: View {
    @Binding var currentView: CurrentView
    
    var body: some View {
        VStack {
            Savings_Expenses()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Main Menu") {
                    currentView = .mainMenu
                }
            }
        }
    }
}

#Preview {
    ExpensesView(currentView: .constant(.expenses))
}
