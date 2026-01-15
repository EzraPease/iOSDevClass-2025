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
                    Group {
                        Button {
                            currentView = .savings
                        } label: {
                            VStack {
                                Text("View Savings")
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
                                Text(viewModel.expenses, format: .currency(code: "USD"))
                                    .italic()
                            }
                            .foregroundStyle(.red)
                        }
                    }
                    .frame(width: 170)
                    
                    Button("View Budget") {
                        currentView = .budgetOverview
                    }
                }
                .padding()
                .glassEffect()
                .shadow(radius: 15)
                .font(.title3)
                .bold()
                
                Spacer()
            }
    }
}

#Preview {
    MainMenuView(currentView: .constant(.mainMenu))
        .environment(BudgetViewModel())
}
