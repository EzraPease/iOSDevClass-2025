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
    @State private var editModeEnabled = false
    private var editButtonText: String {
        if !editModeEnabled {
            return "Edit"
        }
        return "Save"
    }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.cyan)
                .frame(width: scale * 0.35, height: scale * 0.15)
                .overlay {
                    VStack {
                        Text("Current Amount:")
                            .font(.title3)
                            .bold()
                        Text(currentValue, format: .currency(code: "USD"))
                            .italic()
                    }
                }
            
            Spacer(minLength: scale * 0.3)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.cyan)
                .frame(width: scale * 0.45, height: scale * 0.6)
                .overlay {
                    VStack {
                        Text("Edit Mode Enabled: \(editModeEnabled)") // Temporary Text Object
                        
                    }
                    .padding()
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editButtonText) {
                    editModeEnabled.toggle()
                }
            }
        }
    }
}

#Preview {
    Details(scale: 720.666, currentValue: 57291)
}
