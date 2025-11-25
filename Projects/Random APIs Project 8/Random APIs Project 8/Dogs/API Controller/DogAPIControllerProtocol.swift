//
//  DogAPIControllerProtocol.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


protocol DogAPIControllerProtocol {
    func fetchDogImage() async throws -> String
}
