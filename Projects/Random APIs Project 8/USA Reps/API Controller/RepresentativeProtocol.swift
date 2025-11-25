//
//  RepresentativeProtocol.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/25/25.
//

import SwiftUI

protocol RepresenativeAPIControllerProtocol {
    func fetchUSARep(zip: String?) async throws -> [USReps]
}
