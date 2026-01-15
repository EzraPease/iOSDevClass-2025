//
//  MainMenuView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    var body: some View {
            VStack(spacing: 80) {
                Spacer()
                
                Group {
                    Button {
                        currentView = .savings
                    } label: {
                        VStack {
                            Text("View Savings")
                                .font(.title3)
                                .bold()
                            Text(viewModel.savings, format: .currency(code: "USD"))
                                .italic()
                        }
                        .foregroundStyle(.green)
                    }
                    Button {
                        currentView = .expenses
                    } label: {
                        VStack {
                            Text("View Expenses")
                                .font(.title3)
                                .bold()
                            Text(viewModel.expenses, format: .currency(code: "USD"))
                                .italic()
                        }
                        .foregroundStyle(.red)
                    }
                    
                    Button("View Budget") {
                        currentView = .budgetOverview
                    }
                    .font(.title3)
                    .bold()
                }
                .padding()
                .glassEffect()
                .shadow(radius: 15)
                
                Spacer()
            }
    }
}

#Preview {
    MainMenuView(currentView: .constant(.mainMenu))
        .environment(BudgetViewModel())
}
