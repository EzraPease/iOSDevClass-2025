//
//  DogApp.swift
//  Property Wrapper Following Along
//
//  Created by Ezra Pease on 9/26/25.
//

import SwiftUI

@Observable class DogApp {
    var dogs: [Dog]
    var walk: Walk?
    
    init() {
        dogs = []
        walk = nil
    }
}
