//
//  MockNetworkClient.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation

class MockNetworkingClient: NetworkService {
    
    var fetchSchoolsSuccess = false
    var expectedResultForFetchSchools: [School]?
    var expectedErrorForFetchSchools: NetworkError?

    var fetchSATDataSuccess = false
    var expectedResultForFetchSATData: [SatData]?
    var expectedErrorForFetchSATData: NetworkError?
    
    
    func fetchSchools(for request: SchoolsRequest, completion: @escaping (Result<[School], NetworkError>) -> Void) {
        if fetchSchoolsSuccess {
            return completion(.success(expectedResultForFetchSchools ?? []))
        } else {
            return completion(.failure(expectedErrorForFetchSchools ?? .badRequest))
        }
    }
    
    func fetchSATData(for request: SatDataRequest, completion: @escaping (Result<[SatData], NetworkError>) -> Void) {
        if fetchSATDataSuccess {
            return completion(.success(expectedResultForFetchSATData ?? []))
        } else {
            return completion(.failure(expectedErrorForFetchSATData ?? .badRequest))
        }
    }
}
