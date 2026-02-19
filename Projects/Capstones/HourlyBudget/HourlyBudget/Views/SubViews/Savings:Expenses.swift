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
    
    @State var setCategory: BudgetCategories
    @State private var addBudgetEnabled = false
    
    @Query private var savingsBudgets: [Budget]
    @Query private var expensesBudgets: [Budget]
    @Query(filter: #Predicate<Budget> { $0.isPinned }, sort: \.categoryName) private var pinnedBudgets: [Budget]

    let savingsCategory = BudgetCategories.savings.rawValue
    let expensesCategory = BudgetCategories.expenses.rawValue
    
    private var totalAmount: Double {
            switch setCategory {
            case .savings:  return savingsBudgets.reduce(0) { $0 + $1.currentValue }
            case .expenses: return expensesBudgets.reduce(0) { $0 + $1.currentValue }
            case .uncategorized: return 0
            }
        }


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
                                .foregroundStyle(Color("Text"))
                        case .expenses:
                            Text("Total Expenses:")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("Text"))
                        case .uncategorized:
                            Text("Amount Is Not Categorized")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("Text"))
                        }
                        Text(totalAmount, format: .currency(code: "USD"))
                            .foregroundStyle(Color("Text"))
                    }
                    .padding()
                    .frame(maxWidth: 225, maxHeight: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 35)
                            .fill(setCategory == .savings ? Color("PrimaryAccent") : Color("SecondaryAccent"))
                    }
                    // MARK: Categories
                    VStack {
                        switch setCategory {
                        case .savings:
                            Text("Savings Accounts")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("Text"))
                        case .expenses:
                            Text("Expense Accounts")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("Text"))
                        case .uncategorized:
                            Text("Amount Is Not Categorized")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color("Text"))
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
                            .fill(.white)
                    }
                    // MARK: Transactions
                    VStack {
                        Text("Transactions")
                            .bold()
                            .font(.title3)
                            .foregroundStyle(Color("Text"))
                        
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
                            .fill(.white)
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
                .tint(Color("PrimaryAccent"))
            }
        }
        .navigationTitle("Budget List")
        .sheet(isPresented: $addBudgetEnabled) {
            NavigationStack {
                AddBudgetView(selectedCategory: setCategory)
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
                            .foregroundStyle(Color("Text"))
                        Spacer()
                        Text("\(budget.currentValue, format: .currency(code: "USD"))")
                            .foregroundStyle(Color("Text"))
                    }
                    .padding(3)
                }
                .frame(height: 65)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PrimaryAccent").opacity(0.5))
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
                            .foregroundStyle(Color("Text"))
                        Spacer()
                        Text("\(budget.currentValue, format: .currency(code: "USD"))")
                            .foregroundStyle(Color("Text"))
                    }
                    .padding(3)
                }
                .frame(height: 65)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SecondaryAccent").opacity(0.5))
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
                                    .foregroundStyle(Color("NeutralState"))
                                Spacer()
                                Text(transaction.amount, format: .currency(code: "USD"))
                                    .foregroundStyle(Color("Text"))
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
                                    .foregroundStyle(Color("NeutralState"))
                                Spacer()
                                Text(transaction.amount, format: .currency(code: "USD"))
                                    .foregroundStyle(Color("Text"))
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
                            .foregroundStyle(Color("Text"))
        }
    }
}

#Preview {
    Savings_Expenses(setCategory: .savings)
        .environment(BudgetViewModel())
}
