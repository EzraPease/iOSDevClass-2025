//
//  RepresentativeProtocol.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/25/25.
//

import SwiftUI

protocol RepresentativeAPIControllerProtocol {
    func fetchUSARep(zip: String?) async throws -> [USReps]
}


class StubApiCall: RepresentativeAPIControllerProtocol {
    var stubRep: [USReps] = []
    func fetchUSARep(zip: String?) async throws -> [USReps] {
        return stubRep
    }
}
