//
//  Savings:Expenses.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI
import SwiftData



// This view is the subview for both SavingsView and ExpensesView
struct Savings_Expenses: View {
    @Environment(\.modelContext) private var context
    @Environment(BudgetViewModel.self) private var viewModel
    
    @State var totalAmount: Double
    @State var setCategory: BudgetCategories
    @State private var addBudgetEnabled = false
    
    @Query private var savingsBudgets: [Budget]
    @Query private var expensesBudgets: [Budget]
    @Query(filter: #Predicate<Budget> { $0.isPinned }, sort: \.categoryName) private var pinnedBudgets: [Budget]

    let savingsCategory = BudgetCategories.savings.rawValue
    let expensesCategory = BudgetCategories.expenses.rawValue


    init(totalAmount: Double, setCategory: BudgetCategories) {
        _totalAmount = State(initialValue: totalAmount)
        _setCategory = State(initialValue: setCategory)
        _savingsBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == savingsCategory
        }, sort: \Budget.categoryName)
        _expensesBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == expensesCategory
        }, sort: \Budget.categoryName)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 25) {
                    // MARK: Total Value
                    VStack {
                        switch setCategory {
                        case .savings:
                            Text("Total Savings:")
                                .font(.title2)
                                .bold()
                        case .expenses:
                            Text("Total Expenses:")
                                .font(.title2)
                                .bold()
                        case .uncategorized:
                            Text("Amount Is Not Categorized")
                                .font(.title2)
                                .bold()
                        }
                        Text(totalAmount, format: .currency(code: "USD"))
                    }
                    .padding()
                    .frame(maxWidth: 225, maxHeight: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(.cyan.gradient)
                    }
                    // MARK: Categories
                    VStack {
                        switch setCategory {
                        case .savings:
                            Text("Savings Accounts")
                                .font(.title2)
                                .bold()
                        case .expenses:
                            Text("Expense Accounts")
                                .font(.title2)
                                .bold()
                        case .uncategorized:
                            Text("Amount Is Not Categorized")
                                .font(.title2)
                                .bold()
                        }
                        ScrollView {
                            VStack {
                                CategoryListView(setCategory: setCategory)
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding()
                    .frame(maxWidth: 350, maxHeight: 350)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.cyan.gradient)
                    }
                    // MARK: Transactions
                    VStack {
                        Text("Transactions")
                            .bold()
                            .font(.title3)
                        
                        ScrollView {
                            VStack {
                                LogsListView(setCategory: setCategory)
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding()
                    .frame(maxWidth: 350, maxHeight: 350)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.cyan.gradient)
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addBudgetEnabled = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Budget List")
        .sheet(isPresented: $addBudgetEnabled) {
            NavigationStack {
                AddBudgetView()
                    .navigationTitle("New Budget")
                    .navigationBarTitleDisplayMode(.inline) // or .large
            }
            .presentationDetents([.height(475), .large])
            .presentationDragIndicator(.visible)
        }
    }
}
// MARK: Category View
private struct CategoryListView: View {
    @Environment(BudgetViewModel.self) private var viewModel
    
    @Query private var savingsBudgets: [Budget]
    @Query private var expensesBudgets: [Budget]
    @Query(filter: #Predicate<Budget> { $0.isPinned }, sort: \.categoryName) private var pinnedBudgets: [Budget]

    @State var setCategory: BudgetCategories
    
    let savingsCategory = BudgetCategories.savings.rawValue
    let expensesCategory = BudgetCategories.expenses.rawValue


    init(setCategory: BudgetCategories) {
        _setCategory = State(initialValue: setCategory)
        _savingsBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == savingsCategory
        }, sort: \Budget.categoryName)
        _expensesBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == expensesCategory
        }, sort: \Budget.categoryName)
    }
    
    
    var body: some View {
        switch setCategory {
        case .savings:
            if savingsBudgets.isEmpty {
                EmptyView()
            } else {
                ForEach(savingsBudgets) { budget in
                    HStack {
                        Text("\(budget.categoryName):")
                            .bold()
                        Spacer()
                        Text("\(budget.currentValue, format: .currency(code: "USD"))")
                    }
                    .padding(3)
                }
                .frame(height: 65)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.red.gradient)
                }
            }
        case .expenses:
            if expensesBudgets.isEmpty {
                EmptyView()
            } else {
                ForEach(expensesBudgets) { budget in
                    HStack {
                        Text("\(budget.categoryName):")
                            .bold()
                        Spacer()
                        Text("\(budget.currentValue, format: .currency(code: "USD"))")
                    }
                    .padding(3)
                }
            }
        case .uncategorized:
            Text("Why can you see this?")
        }
    }
}

// MARK: Logs View
private struct LogsListView: View {
    @Environment(BudgetViewModel.self) private var viewModel
    
    @Query private var savingsBudgets: [Budget]
    @Query private var expensesBudgets: [Budget]
    @Query(filter: #Predicate<Budget> { $0.isPinned }, sort: \.categoryName) private var pinnedBudgets: [Budget]

    let savingsCategory = BudgetCategories.savings.rawValue
    let expensesCategory = BudgetCategories.expenses.rawValue
    @State var setCategory: BudgetCategories


    init(setCategory: BudgetCategories) {
        _setCategory = State(initialValue: setCategory)
        _savingsBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == savingsCategory
        }, sort: \Budget.categoryName)
        _expensesBudgets = Query(filter: #Predicate<Budget> { budget in
            budget._setCategory == expensesCategory
        }, sort: \Budget.categoryName)
    }
    
    
    var body: some View {
        VStack {
            switch setCategory {
            case .savings:
                if savingsBudgets.isEmpty {
                    EmptyView()
                } else {
                    ForEach(savingsBudgets) { budget in
                        ForEach(budget.transactions) { transaction in
                            HStack {
                                Text(transaction.timeStamp.formatted(date: .abbreviated, time: .omitted))
                                    .bold()
                                Spacer()
                                Text(transaction.amount, format: .currency(code: "USD"))
                            }
                            .padding(3)
                        }
                    }
                }
            case .expenses:
                if expensesBudgets.isEmpty {
                    EmptyView()
                } else {
                    ForEach(expensesBudgets) { budget in
                        ForEach(budget.transactions) { transaction in
                            HStack {
                                Text(transaction.timeStamp.formatted(date: .abbreviated, time: .omitted))
                                    .bold()
                                Spacer()
                                Text(transaction.amount, format: .currency(code: "USD"))
                            }
                            .padding(3)
                        }
                    }
                }
            case .uncategorized:
                Text(viewModel.uncategorized, format: .currency(code: "USD"))
            }
        }
    }
}

// MARK: - Empty View
private struct EmptyView: View {
    var body: some View {
        VStack {
            Text("Nothing Here Yet")
                .bold()
                .italic()
                .font(.subheadline)
        }
    }
}

#Preview {
    Savings_Expenses(totalAmount: 14513241, setCategory: .savings)
        .environment(BudgetViewModel())
}
