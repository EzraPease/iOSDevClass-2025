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
//            let scale = geometry.size.width - 260
            var scale: CGFloat {
                if geometry.size.width < geometry.size.height {
                    return geometry.size.width - 270
                }
                return geometry.size.height - 270
            }
            
            ScrollView {
                VStack {
                    Spacer()
                    
                    LazyVGrid (
                        columns: [
                            //                            GridItem(.fixed(scale), spacing: 16),
                            //                            GridItem(.fixed(scale), spacing: 16)
                            GridItem(.flexible(minimum: 100, maximum: scale)),
                            GridItem(.flexible(minimum: 100, maximum: scale))
                        ]
                    ){ ForEach(viewModel.budgetList) { budget in
                        RoundedRectangle(cornerRadius: 21)
                            .fill(.cyan)
                            .frame(width: scale, height: scale)
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
