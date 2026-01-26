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
            case .budgetOverview:
                BudgetView(currentView: $currentView)
            case .savings:
                SavingsView(currentView: $currentView)
            case .expenses:
                ExpensesView(currentView: $currentView)
            }
        }
        .environment(viewModel)
    }
}

#Preview {
    ContentView()
}
