//
//  Dog.swift
//  Property Wrapper Following Along
//
//  Created by Ezra Pease on 9/26/25.
//


struct Dog: Identifiable {
    var id: String {
        return name
    }
    
    let name: String
}
