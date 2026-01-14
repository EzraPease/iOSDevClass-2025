//
//  BudgetView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct BudgetView: View {
    @State var viewModel = BudgetViewModel()
    @Binding var currentView: CurrentView
    
    var body: some View {
        GeometryReader { geometry in
            var scale: CGFloat {
                if geometry.size.width < geometry.size.height {
                    return geometry.size.width - 280
                }
                return geometry.size.height - 280
            }
            
            ScrollView(.vertical) {
                VStack {
                    Text("Filler VStack Text")
                    
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(viewModel.budgetList) { budget in
                        BudgetCell(scale: scale, currentValue: budget.currentValue)
                    }
                    }
                    .padding(.horizontal, 8)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Main Menu") {
                        currentView = .mainMenu
                    }
                }
            }
            .navigationTitle("Filler Navigation Text")
        }
    }
}

#Preview {
    BudgetView(currentView: .constant(.budgetOverview))
}
