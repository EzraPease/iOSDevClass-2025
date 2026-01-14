//
//  Details.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct Details: View {
    @State var scale: CGFloat
    @State var currentValue: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.cyan)
            .frame(width: scale * 0.6, height: scale * 0.25)
            .overlay {
                Text("\(currentValue)")
            }
        
        Spacer(minLength: scale * 0.3)
        
        RoundedRectangle(cornerRadius: 15)
            .fill(.cyan)
            .frame(width: scale * 0.7, height: scale * 1.1)
            .overlay {
                Text("Settings Section")
            }
    }
}

#Preview {
    Details(scale: 402, currentValue: 57291)
}
