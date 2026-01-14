//
//  ExpensesView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct ExpensesView: View {
    @Binding var currentView: CurrentView
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ExpensesView(currentView: .constant(.expenses))
}
