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
    @State private var addBudgetIsPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            var scale: CGFloat {
                if geometry.size.width < geometry.size.height {
                    return geometry.size.width / 3 + 50
                }
                return geometry.size.height / 3 + 50
            }
            
            ScrollView(.vertical) {
                
                // Pinned Category
                // TODO: Finish setting up pinned section
                VStack {
                    if !viewModel.pinnedBudget.isEmpty {
                        Text("Pinned")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.purple)
                    }
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(viewModel.pinnedBudget) { budget in
                            NavigationLink {
                                DetailView(budgetCell: BudgetCell(scale: scale * 4 - 50, currentValue: budget.currentValue, categoryName: budget.categoryName))
                            } label: {
                                BudgetCell(scale: scale, currentValue: budget.currentValue, categoryName: budget.categoryName)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                    }
                }
                .padding(.horizontal, 8)
                }
                
                // Expenses List
                VStack {
                    if !viewModel.expenseBudget.isEmpty {
                        Text("Expenses")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.red)
                    }
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(viewModel.expenseBudget) { budget in
                            NavigationLink {
                                DetailView(budgetCell: BudgetCell(scale: scale * 4 - 50, currentValue: budget.currentValue, categoryName: budget.categoryName))
                            } label: {
                                BudgetCell(scale: scale, currentValue: budget.currentValue, categoryName: budget.categoryName)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                    }
                }
                .padding(.horizontal, 8)
                }
                
                Spacer(minLength: 80)
                
                // Savings List
                VStack {
                    if !viewModel.savingsBudget.isEmpty {
                        Text("Savings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.green)
                    }
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(viewModel.savingsBudget) { budget in
                            NavigationLink {
                                DetailView(budgetCell: BudgetCell(scale: scale * 4 - 50, currentValue: budget.currentValue, categoryName: budget.categoryName))
                            } label: {
                                BudgetCell(scale: scale, currentValue: budget.currentValue, categoryName: budget.categoryName)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addBudgetIsPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Filler Navigation Text")
            .sheet(isPresented: $addBudgetIsPresented) {
                AddBudget_TransactionView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    BudgetView(currentView: .constant(.budgetOverview))
        .environment(BudgetViewModel())
}
