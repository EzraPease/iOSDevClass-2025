//
//  BudgetView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct BudgetView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    
    var body: some View {
        GeometryReader { geometry in
            var scale: CGFloat {
                if geometry.size.width < geometry.size.height {
                    return geometry.size.width / 4 + 20
                }
                return geometry.size.height / 4 + 20
            }
            
            ScrollView(.vertical) {
                VStack {
                    Text("Filler VStack Text")
                    
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(viewModel.budgetList) { budget in
                        NavigationLink {
                            DetailView(budgetCell: BudgetCell(scale: scale * 4 - 20, currentValue: budget.currentValue))
                        } label: {
                            BudgetCell(scale: scale, currentValue: budget.currentValue)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                    }
                    .padding(.horizontal, 8)
                }
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        currentView = .mainMenu
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
            .navigationTitle("Filler Navigation Text")
        }
    }
}

#Preview {
    BudgetView(currentView: .constant(.budgetOverview))
        .environment(BudgetViewModel())
}
