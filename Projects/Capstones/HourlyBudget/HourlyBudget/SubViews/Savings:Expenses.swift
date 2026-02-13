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

    
    private var categoriesFrameSize: CGFloat {
        switch setCategory {
        case .savings:
            return savingsBudgets.count <= 5 ? 200 : 350
        case .expenses:
            return expensesBudgets.count <= 5 ? 200 : 350
        case .uncategorized:
            return 200
        }
    }
    
    private var transactionsFrameSize: CGFloat {
        switch setCategory {
        case .savings:
            return savingsBudgets.count <= 5 ? 200 : 350
        case .expenses:
            return expensesBudgets.count <= 5 ? 200 : 350
        case .uncategorized:
            return 200
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 0) {
                    // MARK: Total Value
                    RoundedRectangle(cornerRadius: 35)
                        .fill(.cyan)
                        .frame(height: 80)
                        .overlay {
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
                        }
                    // MARK: Categories
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan)
                        .frame(height: categoriesFrameSize)
                        .overlay {
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
                        }
                    // MARK: Logs
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan)
                        .frame(height: transactionsFrameSize)
                        .overlay {
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
                        }
                }
                .padding()
            }
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
            ForEach(savingsBudgets) { budget in
                HStack {
                    Text("\(budget.categoryName):")
                        .bold()
                    Spacer()
                    Text("\(budget.currentValue, format: .currency(code: "USD"))")
                }
                .padding(3)
            }
        case .expenses:
            ForEach(expensesBudgets) { budget in
                HStack {
                    Text("\(budget.categoryName):")
                        .bold()
                    Spacer()
                    Text("\(budget.currentValue, format: .currency(code: "USD"))")
                }
                .padding(3)
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
            case .expenses:
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
            case .uncategorized:
                Text(viewModel.uncategorized, format: .currency(code: "USD"))
            }
        }
    }
}

#Preview {
    Savings_Expenses(totalAmount: 14513241, setCategory: .savings)
}
