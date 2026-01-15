//
//  ContentView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var currentView: CurrentView = .mainMenu
    @State private var viewModel = BudgetViewModel()
    
    var body: some View {
        NavigationStack {
            switch currentView {
            case .mainMenu:
                MainMenuView(currentView: $currentView)
                    .environment(viewModel)
            case .budgetOverview:
                BudgetView(currentView: $currentView)
                    .environment(viewModel)
            case .savings:
                SavingsView(currentView: $currentView)
                    .environment(viewModel)
            case .expenses:
                ExpensesView(currentView: $currentView)
                    .environment(viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
