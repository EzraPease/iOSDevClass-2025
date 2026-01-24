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
    @State private var editedCurrentValue = ""
    @State private var categoryName = ""
    
    @State var defaultCategoryName: String
    
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
                        Text(defaultCategoryName)
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
                        Group {
                            TextField("Category Name", text: $categoryName)
                            TextField("Set Amount", text: $editedCurrentValue)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        .glassEffect()
                        .padding(2)
                        .disabled(!editModeEnabled)
                        .opacity(editModeEnabled ? 1 : 0.7)
                        
                        Spacer()
                    }
                    .padding()
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editButtonText) {
                    if editModeEnabled {
                        normalizeToTwoDecimals()
                        do {
                            try save()
                        } catch {
                            print(error)
                        }
                    }
                    editModeEnabled.toggle()
                }
            }
        }
        .onAppear {
            categoryName = defaultCategoryName
            editedCurrentValue = String(currentValue)
        }
    }
    // TODO: Fix save function so that it updates the category name and currentValue at the top
    private func save() throws {
        guard let valueAsDouble = Double(editedCurrentValue) else { throw DetailsViewErrors.unableToSaveNewValue}
        defaultCategoryName = categoryName
        currentValue = valueAsDouble
    }
    
    private func normalizeToTwoDecimals() {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        // Replace the locale separator with a dot for parsing if needed
        if let number = formatter.number(from: editedCurrentValue) {
            editedCurrentValue = formatter.string(from: number) ?? editedCurrentValue
        }
    }
}

#Preview {
    Details(scale: 720.666, currentValue: 57291, defaultCategoryName: "Example Category")
}
