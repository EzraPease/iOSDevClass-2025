//
//  TestingLabTests.swift
//  TestingLabTests
//
//  Created by Ezra Pease on 1/23/26.
//

import XCTest
@testable import TestingLab

final class TestingLabTests: XCTestCase {

    func testForDualType() {
        let pokemon = Pokemon(firstType: "Grass", secondType: "Ground", ability: "Shell Armor")
        XCTAssertEqual(pokemon.dualType, "Grass Ground")
    }
    
    func testForCanFly() {
        let pokemon = Pokemon(firstType: "Fish", ability: "Levitate")
        XCTAssertTrue(pokemon.canFly())
    }
    
    func testForIsFromKantoRegion() {
        let pokemon = Pokemon(firstType: "Water", ability: "Poision Point", name: "Seadra")
        XCTAssertTrue(pokemon.isKanto())
    }

}
