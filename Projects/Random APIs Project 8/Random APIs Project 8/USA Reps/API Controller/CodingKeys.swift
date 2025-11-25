//
//  CodingKeys.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/25/25.
//

import SwiftUI

struct USRepsResults: Codable {
    let results: [USReps]
}

struct USReps: Codable {
    let name: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
}
