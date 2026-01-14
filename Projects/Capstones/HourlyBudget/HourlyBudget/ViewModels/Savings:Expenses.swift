//
//  Savings:Expenses.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct Savings_Expenses: View {
    
    
    var body: some View {
        VStack {
            Group {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.cyan)
                    .overlay {
                        Text("Total Amount")
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
    Savings_Expenses()
}
