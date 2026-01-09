//
//  MainMenuView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct MainMenuView: View {
    @Binding var currentView: CurrentView
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 80) {
                Spacer()
                
                Button {
                    currentView = .savings
                } label: {
                    Text("Savings Button")
                }
                Button {
                    currentView = .expenses
                } label: {
                    Text("Expenses Button")
                }
                
                Button("View Budget") {
                    currentView = .budgetOverview
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainMenuView(currentView: .constant(.mainMenu))
}
