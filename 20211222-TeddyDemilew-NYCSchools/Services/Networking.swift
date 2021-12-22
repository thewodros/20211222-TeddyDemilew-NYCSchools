//
//  Networking.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case noData
    case decodingError
}

struct SchoolsRequest {
    let urlString: String = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    let zip: String?
    
    var url: URL? {
        var urlString: String = urlString
        if let zip = zip {
            urlString += "?zip=\(zip)"
        }

        return URL(string: urlString)
    }
}

struct SatDataRequest {
    let urlString: String = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    let dbn: String
    
    var url: URL? {
        URL(string: "\(urlString)?dbn=\(dbn)")
    }
}

protocol NetworkService {
    func fetchSchools(for request: SchoolsRequest, completion: @escaping (Result<[School], NetworkError>) -> Void)
    func fetchSATData(for request: SatDataRequest, completion: @escaping (Result<[SatData], NetworkError>) -> Void)
}
