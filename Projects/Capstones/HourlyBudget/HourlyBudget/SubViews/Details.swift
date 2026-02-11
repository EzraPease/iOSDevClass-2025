//
//  Details.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI

struct Details: View {
    @Environment(BudgetViewModel.self) var viewModel
    @State var scale: CGFloat
    @State var budget: Budget
    @State private var titleCategoryName = ""
    @State private var titleCurrentValue = ""
//    @State private var stringCurrentValue = ""
    @State private var editModeEnabled = false
    @State private var showDeleteConfirm = false
    @State private var showUnableToSaveText = false
    
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
                        Text(budget.categoryName)
                            .font(.title3)
                            .bold()
                        Text(budget.currentValue, format: .currency(code: "USD"))
                            .italic()
                    }
                }
            
            Spacer(minLength: scale * 0.3)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.cyan)
                .frame(width: scale * 0.45, height: scale * 0.6)
                .overlay {
                    VStack {
                        if showUnableToSaveText {
                            Text("Uh Oh! Something went wrong, please try again.")
                                .italic()
                                .foregroundStyle(.red)
                                .padding()
                        }
                        Text("Edit Mode Enabled: \(editModeEnabled)") // Temporary Text Object
                        Group {
                            TextField("Category Name", text: $budget.categoryName)
                            TextField("Set Amount", text: $titleCurrentValue)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        .glassEffect()
                        .padding(2)
                        .disabled(!editModeEnabled)
                        .opacity(editModeEnabled ? 1 : 0.5)
                        
                        Spacer()
                    }
                    .padding()
                }
        }
        .toolbar {
            if editModeEnabled {
            ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Button("Delete", role: .destructive) {
                            showDeleteConfirm = true
                        }
                        .foregroundStyle(.red)
                        .bold()
                        .alert("Delete this budget?", isPresented: $showDeleteConfirm) {
                            Button("Delete", role: .destructive) {
                                // Perform deletion
                            }
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("This action cannot be undone.")
                        }
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(editButtonText) {
                    if editModeEnabled {
                        normalizeToTwoDecimals()
                        do {
                            try save()
                        } catch {
                            showUnableToSaveError(error: error)
                            titleCategoryName = budget.categoryName
                            titleCurrentValue = String(budget.currentValue)
                        }
                    }
                    editModeEnabled.toggle()
                }
            }
        }
        .onAppear {
            titleCategoryName = budget.categoryName
            titleCurrentValue = String(budget.currentValue)
        }
    }
    // MARK: - Functions
    // TODO: Fix save function so that it updates the category name and currentValue at the top
    private func save() throws {
        guard let valueAsDouble = Double(titleCurrentValue) else { throw DetailsViewErrors.unableToSaveNewValue("ERROR: Was unable to convert \(titleCurrentValue) to a Double") }
        budget.categoryName = titleCategoryName
        budget.currentValue = valueAsDouble
    }
    
    private func showUnableToSaveError(error: Error) {
        print(error)
        showUnableToSaveText = true
        Task {
            try? await Task.sleep(for: .seconds(5))
            showUnableToSaveText = false
        }
    }
    
    private func normalizeToTwoDecimals() {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        // Replace the locale separator with a dot for parsing if needed
        if let number = formatter.number(from: titleCurrentValue) {
            titleCurrentValue = formatter.string(from: number) ?? titleCurrentValue
        }
    }
}

#Preview {
    Details(scale: 720.666, budget: Budget(categoryName: "Example Category", currentValue: 471203.48))
        .environment(BudgetViewModel())
}
