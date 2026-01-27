//
//  TDDPasswordValidationLabTests.swift
//  TDDPasswordValidationLabTests
//
//  Created by Ezra Pease on 1/27/26.
//

import XCTest
@testable import TDDPasswordValidationLab

final class TDDPasswordValidationLabTests: XCTestCase {
    let password = "Password12!"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidatePassword_ContainsMoreThan8Characters() throws {
        
        XCTAssert(password.count >= 8, "Password must have at least 8 characters")
    }
    func testValidatePassword_ContainsLessThan30Characters() throws {
        XCTAssert(password.count <= 30, "Password cannot have more than 30 characters")
    }
    
    func testValidatePassword_ContainsUpperCase() throws {
        let hasUppercase = password.contains { $0.isUppercase }
        
        XCTAssertTrue(hasUppercase, "Password must contain at least one uppercase letter")
    }

    func testValidatePassword_ContainsLowerCase() throws {
        let hasLowercase = password.contains { $0.isLowercase }
        
        XCTAssertTrue(hasLowercase, "Password must contain at least one lowercase letter")
    }
    
    func testValidatePassword_ContainsNumber() throws {
        let hasNumber = password.contains { $0.isNumber }
        
        XCTAssertTrue(hasNumber, "Password must contain at least one number")
    }
    
    func testValidatePassword_ContainsSpecialCharacter() throws {
        let hasSpecial = password.contains { !$0.isLetter && !$0.isNumber && !$0.isWhitespace }
        
        XCTAssertTrue(hasSpecial, "Password must contain at least one special character")
    }

    func testValidatePassword_DoesNotContainSequence() throws {
        let hasSequence = Functions.containsSequentialCharacters(password)
        
        XCTAssertFalse(hasSequence, "Password must not contain sequential letteres or numbers")
    }


}
