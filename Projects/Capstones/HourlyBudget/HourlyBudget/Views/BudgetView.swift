//
//  BudgetView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    @Environment(BudgetViewModel.self) var viewModel
    @Binding var currentView: CurrentView
    @State private var editBudgetModeEnabled: Bool = false
    
    @Query private var savingsBudgets: [Budget]
    @Query private var expensesBudgets: [Budget]
    @Query(filter: #Predicate<Budget> { $0.isPinned }, sort: \.categoryName) private var pinnedBudgets: [Budget]
    
    let savingsCategory = BudgetCategories.savings.rawValue
    let expensesCategory = BudgetCategories.expenses.rawValue
    
    
    init(currentView: Binding<CurrentView>) {
        self._currentView = currentView
        _savingsBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == savingsCategory
        }, sort: \Budget.categoryName)
        _expensesBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == expensesCategory
        }, sort: \Budget.categoryName)
    }

    
    var body: some View {
        GeometryReader { geometry in
            var scale: CGFloat {
                if geometry.size.width < geometry.size.height {
                    return geometry.size.width / 3 + 50
                }
                return geometry.size.height / 3 + 50
            }
            
            ScrollView(.vertical) {
                
                // MARK: - Pinned List
                // TODO: Finish setting up pinned section
                VStack {
                    if !pinnedBudgets.isEmpty {
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
                                DetailView(budget: budget, scale: scale * 4 - 50)
                            } label: {
                                BudgetCell(scale: scale, currentValue: budget.currentValue, categoryName: budget.categoryName)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                    }
                }
                .padding(.horizontal, 8)
                }
                
                // MARK: - Expenses List
                VStack {
                    if !expensesBudgets.isEmpty {
                        Text("Expenses")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.red)
                    }
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(expensesBudgets) { budget in
                            NavigationLink {
                                DetailView(budget: budget, scale: scale * 4 - 50)
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
                
                // MARK: - Savings List
                VStack {
                    if !savingsBudgets.isEmpty {
                        Text("Savings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.green)
                    }
                    LazyVGrid (
                        columns: [
                            GridItem(.adaptive(minimum: scale, maximum: .infinity))
                        ]
                    ){ ForEach(savingsBudgets) { budget in
                            NavigationLink {
                                DetailView(budget: budget, scale: scale * 4 - 50)
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
                        editBudgetModeEnabled = true
                        print("Savings Budgets: \(savingsBudgets)")
                        print("Expenses Budgets: \(expensesBudgets)")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Budget List")
            .sheet(isPresented: $editBudgetModeEnabled) {
                NavigationStack {
                    AddBudgetView()
                        .navigationTitle("New Budget")
                        .navigationBarTitleDisplayMode(.inline) // or .large
                }
            }
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    BudgetView(currentView: .constant(.budgetOverview))
        .environment(BudgetViewModel())
}
