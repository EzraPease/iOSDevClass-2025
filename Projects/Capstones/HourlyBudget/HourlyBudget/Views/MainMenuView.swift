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
            VStack(spacing: 80) {
                Spacer()
                
                Group {
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
}
