//
//  _0211222_TeddyDemilew_NYCSchoolsTests.swift
//  20211222-TeddyDemilew-NYCSchoolsTests
//
//  Created by Teddy Demilew on 12/22/21.
//

import XCTest
@testable import _0211222_TeddyDemilew_NYCSchools

class _0211222_TeddyDemilew_NYCSchoolsTests: XCTestCase {

    var mockNetworkingClient: MockNetworkingClient!
    
    override func setUpWithError() throws {
        mockNetworkingClient = MockNetworkingClient()
    }

    override func tearDownWithError() throws {
        mockNetworkingClient = nil
    }

    func testModelView_forSuccessfulFetchSchool() throws {
        mockNetworkingClient.expectedResultForFetchSchools = [School(dbn: "123"),
                                                              School(dbn: "456"),
                                                              School(dbn: "789")]
        mockNetworkingClient.expectedErrorForFetchSchools = nil
        mockNetworkingClient.fetchSchoolsSuccess = true
        
        let expectation = expectation(description: "fetchSchool")
        
        let request = SchoolsRequest(zip: nil)
        
        mockNetworkingClient.fetchSchools(for: request) { result in
            var model: HomeViewController.Model?

            switch result {
            case .success(let schools):
                model = HomeViewController.Model(schools: schools, error: nil)
            case .failure(let error):
                model = HomeViewController.Model(schools: nil, error: error)
            }

            XCTAssertNotNil(model?.schools)
            XCTAssertEqual(model?.schools?.count, 3)
            XCTAssertNil(model?.error)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testModelView_forFailedFetchSchool() throws {
        mockNetworkingClient.expectedResultForFetchSchools = nil
        mockNetworkingClient.expectedErrorForFetchSchools = .badRequest
        mockNetworkingClient.fetchSchoolsSuccess = false
        
        let expectation = expectation(description: "fetchSchool")
        
        let request = SchoolsRequest(zip: nil)
        
        mockNetworkingClient.fetchSchools(for: request) { result in
            var model: HomeViewController.Model?

            switch result {
            case .success(let schools):
                model = HomeViewController.Model(schools: schools, error: nil)
            case .failure(let error):
                model = HomeViewController.Model(schools: nil, error: error)
            }

            XCTAssertNil(model?.schools)
            XCTAssertNotNil(model?.error)
            XCTAssertEqual(model?.error, .badRequest)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testModelView_forSuccessfulFetchSATData() throws {
        mockNetworkingClient.expectedResultForFetchSATData = [SatData(dbn: "123"),
                                                              SatData(dbn: "456"),
                                                              SatData(dbn: "789")]
        mockNetworkingClient.expectedErrorForFetchSATData = nil
        mockNetworkingClient.fetchSATDataSuccess = true
        
        let expectation = expectation(description: "fetchSatData")
        
        let request = SatDataRequest(dbn: "123")
        
        mockNetworkingClient.fetchSATData(for: request) { result in
            var model: SatDataDetailsViewController.Model?
            let school = School(dbn: "123")

            switch result {
            case .success(let satData):
                model = SatDataDetailsViewController.Model(isLoading: false, school: school, satData: satData, error: nil)
            case .failure(let error):
                model = SatDataDetailsViewController.Model(isLoading: false, school: school, satData: nil, error: error)
            }

            XCTAssertNotNil(model?.satData)
            XCTAssertEqual(model?.satData?.count, 3)
            XCTAssertNil(model?.error)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testModelView_forFailedFetchSATData() throws {
        mockNetworkingClient.expectedResultForFetchSATData = nil
        mockNetworkingClient.expectedErrorForFetchSATData = .badRequest
        mockNetworkingClient.fetchSATDataSuccess = false
        
        let expectation = expectation(description: "fetchSatData")
        
        let request = SatDataRequest(dbn: "123")
        
        mockNetworkingClient.fetchSATData(for: request) { result in
            var model: SatDataDetailsViewController.Model?
            let school = School(dbn: "123")

            switch result {
            case .success(let satData):
                model = SatDataDetailsViewController.Model(isLoading: false, school: school, satData: satData, error: nil)
            case .failure(let error):
                model = SatDataDetailsViewController.Model(isLoading: false, school: school, satData: nil, error: error)
            }

            XCTAssertNil(model?.satData)
            XCTAssertNotNil(model?.error)
            XCTAssertEqual(model?.error, .badRequest)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

}
