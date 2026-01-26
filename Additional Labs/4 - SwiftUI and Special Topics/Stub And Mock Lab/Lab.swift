//
//  Lab.swift
//  Stub And Mock Lab
//
//  Created by Ezra Pease on 1/26/26.
//

import Foundation




protocol NetworkService {
    func fetchData() async -> Data?
}

class FakeNetworkService: NetworkService {
    func fetchData(completion: (Data?) -> Void) {
        completion(nil)
    }
}
class MockNetworkService: NetworkService {
    var fetchDataCalled = false
    
    func fetchData(completion: (Data?) -> Void) {
        fetchDataCalled = true
    }
}
class StubNetworkService: NetworkService {
    func fetchData(completion: (Data?) -> Void) {
        let data = Data()
        completion(data)
    }
}

class DataFetcher {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchData(completion: @escaping (Data?) -> Void) {
        networkService.fetchData { data in
            completion(data)
        }
    }
}
