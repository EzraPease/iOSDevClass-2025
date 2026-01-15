//
//  Savings:Expenses.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct Savings_Expenses: View {
    @State var totalAmount: Double
    @State var setCategory: BudgetCategories
    
    var body: some View {
        VStack {
            Group {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.cyan)
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
                RoundedRectangle(cornerRadius: 20)
                    .fill(.cyan)
                    .overlay {
                        Text("Savings / Expenses")
                    }
                RoundedRectangle(cornerRadius: 20)
                    .fill(.cyan)
                    .overlay {
                        Text("Transaction Logs")
                    }
            }
            .padding()
        }
    }
}

#Preview {
    Savings_Expenses(totalAmount: 57281, setCategory: .savings)
}
