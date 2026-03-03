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
    @State private var addBudgetEnabled: Bool = false
    @State private var editBudgetViewShown = false
    @State private var selectedBudget: Budget? = nil
    
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
                if pinnedBudgets.isEmpty && savingsBudgets.isEmpty && expensesBudgets.isEmpty {
                    HStack {
                        Spacer()
                        
                        EmptyView()
                        
                        Spacer()
                    }
                } else {
                    
                    // MARK: - Pinned List
                    // TODO: Finish setting up pinned section
                    VStack {
                        if !pinnedBudgets.isEmpty {
                            Text("Pinned")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(Color.text)
                        }
                        LazyVGrid (
                            columns: [
                                GridItem(.adaptive(minimum: scale, maximum: .infinity))
                            ]
                        ){ ForEach(pinnedBudgets) { budget in
                            NavigationLink {
                                DetailView(budget: budget, scale: scale * 4 - 50)
                            } label: {
                                BudgetCell(scale: scale, budget: budget)
                                    .foregroundStyle(Color.text)
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
                                .foregroundStyle(Color.secondaryAccent)
                        }
                        LazyVGrid (
                            columns: [
                                GridItem(.adaptive(minimum: scale, maximum: .infinity))
                            ]
                        ){ ForEach(expensesBudgets) { budget in
                            NavigationLink {
                                DetailView(budget: budget, scale: scale * 4 - 50)
                            } label: {
                                BudgetCell(scale: scale, budget: budget)
                                    .foregroundStyle(Color.text)
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
                                .foregroundStyle(Color.primaryAccent)
                        }
                        LazyVGrid (
                            columns: [
                                GridItem(.adaptive(minimum: scale, maximum: .infinity))
                            ]
                        ){ ForEach(savingsBudgets) { budget in
                            NavigationLink {
                                DetailView(budget: budget, scale: scale * 4 - 50)
                            } label: {
                                BudgetCell(scale: scale, budget: budget)
                                    .foregroundStyle(Color.text)
                            }
                            .padding()
                            .contextMenu {
                                // TODO: Add the logic to the expenses and pinned sections after completed
                                Button {
                                    // TODO: Add Edit Logic
                                    editBudgetViewShown = true
                                    selectedBudget = budget
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Button(role: .destructive) {
                                    // TODO: Add Delete Logic
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
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
                    Menu {
                        Button {
                            addBudgetEnabled = true
                        } label: {
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                            Text("Add Budget")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "dollarsign")
                            Text("Add Income")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(Color.primaryAccent)
                }
            }
            .navigationTitle("Budget List")
            .sheet(isPresented: $addBudgetEnabled) {
                NavigationStack {
                    AddBudgetView()
                        .navigationTitle("New Budget")
                        .navigationBarTitleDisplayMode(.inline) // or .large
                }
                .presentationDetents([.height(475)])
                .presentationDragIndicator(.visible)
                .presentationBackground(.clear)
            }
            .sheet(item: $selectedBudget) { budget in
                NavigationStack {
                        EditView(budget: budget)
                            .navigationTitle("Edit Details")
                            .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

// MARK: - Empty View
private struct EmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
                Text("Nothing here Yet")
                Text("Tap + to start budgeting!")
        }
        .font(.title2)
        .bold()
        .italic()
        .foregroundStyle(Color.text)
        .padding()
    }
}

#Preview {
    ContentView()
}
