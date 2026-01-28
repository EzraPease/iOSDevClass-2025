//
//  FineHeresAViewModel.swift
//  TDDPasswordValidationLab
//
//  Created by Ezra Pease on 1/27/26.
//

import Foundation

@Observable
class FineHeresAViewModelBozo {
    var password = ""
    var passwordValidityChecks: [Bool] = []
    
    
    func validatePassword() {
        passwordValidityChecks.removeAll()
        testValidatePassword_ContainsMoreThan8Characters()
        testValidatePassword_ContainsLessThan30Characters()
        testValidatePassword_ContainsLowerCase()
        testValidatePassword_ContainsUpperCase()
        testValidatePassword_ContainsNumber()
        testValidatePassword_ContainsSpecialCharacter()
        testValidatePassword_DoesNotContainSequence()
    }
    

    func testValidatePassword_ContainsMoreThan8Characters() {
        
        if password.count >= 8 {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }
    func testValidatePassword_ContainsLessThan30Characters() {
        if password.count <= 30 {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }
    
    func testValidatePassword_ContainsUpperCase() {
        let hasUppercase = password.contains { $0.isUppercase }
        
        if hasUppercase {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }

    func testValidatePassword_ContainsLowerCase() {
        let hasLowercase = password.contains { $0.isLowercase }
        
        if hasLowercase {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }
    
    func testValidatePassword_ContainsNumber() {
        let hasNumber = password.contains { $0.isNumber }
        
        if hasNumber {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }
    
    func testValidatePassword_ContainsSpecialCharacter() {
        let hasSpecial = password.contains { !$0.isLetter && !$0.isNumber && !$0.isWhitespace }
        
        if hasSpecial {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }

    func testValidatePassword_DoesNotContainSequence() {
        let hasSequence = Functions.containsSequentialCharacters(password)
        
        if !hasSequence {
            passwordValidityChecks.append(true)
        } else {
            passwordValidityChecks.append(false)
        }
    }
}


enum Functions {
    /// Returns `true` if the password contains either:
    /// - an ascending sequence of characters (e.g. "abc", "123")
    /// - a repeating sequence of the same character (e.g. "aaa", "444")
    static func containsSequentialCharacters(
        _ password: String,
        sequenceLength: Int = 3
    ) -> Bool {

        // Convert each Unicode scalar in the password into its integer value.
        // This allows us to compare characters numerically to detect sequences.
        let unicodeScalarValues: [Int] = password.unicodeScalars.map {
            Int($0.value)
        }

        // If the password is shorter than the sequence length we are checking for,
        // it cannot possibly contain a disallowed sequence.
        guard unicodeScalarValues.count >= sequenceLength else {
            return false
        }

        // Iterate over every possible starting position for a sequence
        // of the specified length within the password.
        for startingIndex in 0...(unicodeScalarValues.count - sequenceLength) {

            // Assume the sequence is valid until proven otherwise.
            // These flags will be flipped if a comparison fails.
            var isAscendingSequence = true
            var isRepeatingSequence = true

            // Compare each character in the candidate sequence to the first character.
            for offsetFromStart in 1..<sequenceLength {
                let currentValue = unicodeScalarValues[startingIndex + offsetFromStart]
                let firstValue = unicodeScalarValues[startingIndex]

                // Check for ascending order (e.g. a → b → c or 1 → 2 → 3)
                // Each subsequent character must increase by exactly 1.
                if currentValue != firstValue + offsetFromStart {
                    isAscendingSequence = false
                }

                // Check for repeating characters (e.g. a → a → a or 4 → 4 → 4)
                // All characters must be identical to the first.
                if currentValue != firstValue {
                    isRepeatingSequence = false
                }
            }

            // If either an ascending or repeating sequence was detected,
            // the password violates the sequence rule.
            if isAscendingSequence || isRepeatingSequence {
                return true
            }
        }

        // No invalid sequences were found in the password.
        return false
    }

}
