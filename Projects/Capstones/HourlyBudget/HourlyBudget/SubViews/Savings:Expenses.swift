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
    @State private var categoriesFrameSize: CGFloat = 200
    
    var body: some View {
        let categoriesFrameSize: CGFloat = {
            switch setCategory {
            case .savings:
                return viewModel.savingsBudget.count <= 5 ? 200 : 350
            case .expenses:
                return viewModel.expenseBudget.count <= 5 ? 200 : 350
            case .uncategorized:
                // This should never run
                return 200
            }
        }()
        
        ScrollView {
            VStack {
                Group {
                    // Total Value
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan)
                        .frame(height: 200)
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
                                Text("Savings / Expenses")
                                    .font(.title3)
                                    .bold()
                                ScrollView {
                                    VStack {
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
                                .scrollIndicators(.hidden)
                            }
                            .padding()
                        }
                    // Logs
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan)
                        .frame(height: 200)
                        .overlay {
                            Text("Transaction Logs")
                        }
                }
                .padding()
            }
        }
    }
}

#Preview {
    Savings_Expenses(totalAmount: 57281, setCategory: .savings, viewModel: BudgetViewModel())
}
