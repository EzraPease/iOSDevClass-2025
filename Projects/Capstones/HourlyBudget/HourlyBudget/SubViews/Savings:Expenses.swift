//
//  Savings:Expenses.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

// This view is the subview for both SavingsView and ExpensesView
struct Savings_Expenses: View {
    @State var totalAmount: Double
    @State var setCategory: BudgetCategories
    @State var viewModel: BudgetViewModel
    
    private var categoriesFrameSize: CGFloat {
        switch setCategory {
        case .savings:
            return viewModel.savingsBudget.count <= 5 ? 200 : 350
        case .expenses:
            return viewModel.expenseBudget.count <= 5 ? 200 : 350
        case .uncategorized:
            return 200
        }
    }
    
    private var transactionsFrameSize: CGFloat {
        switch setCategory {
        case .savings:
            return viewModel.savingsBudget.count <= 5 ? 200 : 350
        case .expenses:
            return viewModel.expenseBudget.count <= 5 ? 200 : 350
        case .uncategorized:
            return 200
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    // Total Value
                    RoundedRectangle(cornerRadius: 20)
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
                    // Categories
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
                                        CategoryListView(setCategory: setCategory, viewModel: viewModel)
                                    }
                                }
                                .scrollIndicators(.hidden)
                            }
                            .padding()
                        }
                    // Logs
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
                                        LogsListView(setCategory: setCategory, viewModel: viewModel)
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

private struct CategoryListView: View {
    let setCategory: BudgetCategories
    let viewModel: BudgetViewModel
    
    var body: some View {
        switch setCategory {
        case .savings:
            ForEach(viewModel.savingsBudget) { savings in
                HStack {
                    Text("\(savings.categoryName):")
                        .bold()
                    Spacer()
                    Text("\(savings.currentValue, format: .currency(code: "USD"))")
                }
                .padding(3)
            }
        case .expenses:
            ForEach(viewModel.expenseBudget) { expenses in
                HStack {
                    Text("\(expenses.categoryName):")
                        .bold()
                    Spacer()
                    Text("\(expenses.currentValue, format: .currency(code: "USD"))")
                }
                .padding(3)
            }
        case .uncategorized:
            Text("Why can you see this?")
        }
    }
}

private struct LogsListView: View {
    let setCategory: BudgetCategories
    let viewModel: BudgetViewModel
    
    var body: some View {
        VStack {
            switch setCategory {
            case .savings:
                ForEach(viewModel.savingsBudget) { budget in
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
                ForEach(viewModel.expenseBudget) { budget in
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
    Savings_Expenses(totalAmount: 57281, setCategory: .savings, viewModel: BudgetViewModel())
}
