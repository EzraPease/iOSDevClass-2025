//
//  Stub_And_Mock_LabTests.swift
//  Stub And Mock LabTests
//
//  Created by Ezra Pease on 1/26/26.
//

import XCTest
@testable import Stub_And_Mock_Lab

final class Stub_And_Mock_LabTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFakeObject() throws {
        
    }
    
    func testMockObject() throws {
        
    }
    
    func testStubObject() async throws {
        let data = Data()
        let stubNetworkService = StubNetworkService()
        let dataFetcher = DataFetcher(networkService: stubNetworkService)
        var completionData: Data?
        
        completionData = await dataFetcher.fetchData
        
        
        XCTAssertEqual(completionData, data)
    }

}
