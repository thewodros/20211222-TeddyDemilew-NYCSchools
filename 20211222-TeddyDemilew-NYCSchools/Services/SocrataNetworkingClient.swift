//
//  SocrataNetworkingClient.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation

class SocrataNetworkingClient: NetworkService {
    
    /// Fetches list of schools
    func fetchSchools(for request: SchoolsRequest, completion: @escaping (Result<[School], NetworkError>) -> Void) {
        guard let url = request.url else {
            completion(.failure(.badURL))
            return
        }

        fetch(url: url) { (result: Result<[School], NetworkError>) in
            completion(result)
        }
    }
    
    /// Fetches SAT Data for a School
    func fetchSATData(for request: SatDataRequest, completion: @escaping (Result<[SatData], NetworkError>) -> Void) {
        guard let url = request.url else {
            completion(.failure(.badURL))
            return
        }

        fetch(url: url) { (result: Result<[SatData], NetworkError>) in
            completion(result)
        }
    }
}

private extension SocrataNetworkingClient {
    private func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
