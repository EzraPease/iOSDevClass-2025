//
//  MainMenuView.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack(spacing: 80) {
            Spacer()
            
            Button {
                
            } label: {
                Text("Savings Button")
            }
            Button {
                
            } label: {
                Text("Expenses Button")
            }

            Button("View Budget") {
                
            }
            
            Spacer()
        }
    }
}

#Preview {
    MainMenuView()
}
