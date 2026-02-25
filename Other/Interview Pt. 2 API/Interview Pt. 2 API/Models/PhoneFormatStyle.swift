//
//  PhoneFormatStyle.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/25/26.
//
import Foundation

struct PhoneFormatStyle: FormatStyle {
    typealias FormatInput = String
    typealias FormatOutput = String

    func format(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        
        // Handle a standard 10-digit US number
        if digits.count == 10 {
            let area = digits.prefix(3)
            let mid = digits.dropFirst(3).prefix(3)
            let last = digits.dropFirst(6)
            return "(\(area)) \(mid)-\(last)"
        }
        
        // Return original if it doesn't match 10 digits
        return value 
    }
}

// Create an extension to make the syntax pretty
extension FormatStyle where Self == PhoneFormatStyle {
    static var phoneNumber: PhoneFormatStyle { .init() }
}
