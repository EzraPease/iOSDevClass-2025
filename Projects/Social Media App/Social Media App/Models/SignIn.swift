//
//  SignIn.swift
//  Social Media App
//
//  Created by Ezra Pease on 1/29/26.
//

import Foundation


struct SignIn: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var userUUID: UUID
    var secret: UUID
    var userName: String
}
