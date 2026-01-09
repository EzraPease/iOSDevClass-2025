//
//  ContentView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/8/26.
//

import SwiftUI

struct ContentView: View {
    private var currentView: CurrentView = .mainMenu
    
    var body: some View {
        switch currentView {
        case .mainMenu:
            MainMenuView()
        case .budgetOverview:
            BudgetView()
        case .savings:
            SavingsView()
        case .expenses:
            ExpensesView()
        case .detailView:
            DetailView()
        case .advancedDetails:
            AdvancedDetailView()
        }
    }
}

#Preview {
    ContentView()
}
