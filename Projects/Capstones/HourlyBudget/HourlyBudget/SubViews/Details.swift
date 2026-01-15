//
//  Details.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct Details: View {
    @State var scale: CGFloat
    @State var currentValue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.cyan)
            .frame(width: scale * 0.35, height: scale * 0.15)
            .overlay {
                Text(currentValue, format: .currency(code: "USD"))
            }
        
        Spacer(minLength: scale * 0.3)
        
        RoundedRectangle(cornerRadius: 15)
            .fill(.cyan)
            .frame(width: scale * 0.45, height: scale * 0.6)
            .overlay {
                Text("Settings Section")
            }
    }
}

#Preview {
    Details(scale: 720.666, currentValue: 57291)
}
