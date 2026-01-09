//
//  BudgetView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct BudgetView: View {
    @State var viewModel = BudgetViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let scale = geometry.size.width - 250
            
            ScrollView {
                VStack {
                    Spacer()
                    
                    LazyHGrid (
                        rows: [
                            GridItem(.fixed(scale), spacing: 16),
                            GridItem(.fixed(scale), spacing: 16)
                        ]
                    ){ ForEach(viewModel.budgetList) { budget in
                        RoundedRectangle(cornerRadius: 21)
                            .fill(.cyan)
                            .frame(width: 150, height: 150)
                            .overlay {
                                VStack {
                                    Text("\(budget.currentValue)")
                                    Image(systemName: "photo")
                                }
                            }
                    }
                        
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    BudgetView()
}
