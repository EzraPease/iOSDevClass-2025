//
//  Random_APIs_Project_8Tests.swift
//  Random APIs Project 8Tests
//
//  Created by Ezra Pease on 1/26/26.
//

import XCTest
@testable import Random_APIs_Project_8

final class Random_APIs_Project_8Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUSRep_stubTesting() async throws {
        // Arrange
        let stub = StubApiCall()
        stub.stubRep = [
            USReps(
                name: "Jane Doe",
                state: "CA",
                district: "District 1",
                phone: "555-123-4567",
                office: "12",
                link: "https://example.com/janedoe"
            )
        ]

        // Act
        let reps = try await stub.fetchUSARep(zip: "90210")

        // Assert
        XCTAssertEqual(reps.count, 1)
        XCTAssertEqual(reps.first?.name, "Jane Doe")
        XCTAssertEqual(reps.first?.state, "CA")
    }
    
    func testFetchUSRep_apiTesting_returnsValues() async throws {
        let api = RepresentativeAPIController()
        
        do {
            let apiValue = try await api.fetchUSARep(zip: "84058")
            
            
            XCTAssertNoThrow(apiValue)
        } catch {
            print(error)
        }
        
    }

}
