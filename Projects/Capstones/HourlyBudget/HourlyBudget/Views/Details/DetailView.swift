//
//  DetailView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct DetailView: View {
    @State var budgetCell: BudgetCell?
    
    var body: some View {
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    if let budgetCell {
                        Details(scale: budgetCell.scale, currentValue: budgetCell.currentValue)
                    } else {
                        Text("No budget found - Try again later")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onAppear {
                if let budgetCell {
                    print(budgetCell.scale)
                }
            }
    }
}

#Preview {
    // Scale 402 for iPhone 17 Pro
    DetailView(budgetCell: BudgetCell(scale: 720.666, currentValue: 48281, categoryName: "Example Category"))
//    DetailView(currentView: .constant(.detailView), budgetCell: nil)
}
