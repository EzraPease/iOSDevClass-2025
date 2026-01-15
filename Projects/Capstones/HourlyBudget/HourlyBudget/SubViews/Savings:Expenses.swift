//
//  Savings:Expenses.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct Savings_Expenses: View {
    @State var totalAmount: Double
    @State var setCatagory: BudgetCatagories
    
    var body: some View {
        VStack {
            Group {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.cyan)
                    .overlay {
                        VStack {
                            switch setCatagory {
                            case .savings:
                                Text("Total Savings:")
                            case .expenses:
                                Text("Total Expenses:")
                            case .uncategorized:
                                Text("Amount Is Not Categorized")
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

//#Preview {
//    Savings_Expenses(totalAmount: 57281)
//}
