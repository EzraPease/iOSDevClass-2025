//
//  Errors.swift
//  HourlyBudget
//
//  Created by Ezra Pease on 1/23/26.
//

enum DetailsViewErrors: Error {
    case failedToSave
    case unableToSaveNewValue(String)
}

enum NewBudgetErrors: Error {
    case incompleteData
    case invalidValue
}
