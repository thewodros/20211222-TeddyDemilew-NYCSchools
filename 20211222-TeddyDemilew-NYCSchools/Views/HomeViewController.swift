//
//  ViewController.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class HomeViewController: UIViewController {

    var client: SocrataNetworkingClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        client = SocrataNetworkingClient()
        
        fetchSchools()
        fetchSATData()
    }
}


// test networking layer
private extension HomeViewController {
    func fetchSchools() {
        let request = SchoolsRequest(zip: nil)

        client.fetchSchools(for: request) { result in
            switch result {
            case .success(let schools):
                print("Number of schools: \(schools.count)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }

    }

    func fetchSATData() {
        let request = SatDataRequest(dbn: "01M292")
        
        client.fetchSATData(for: request) { result in
            switch result {
            case .success(let satData):
                print("satData: \(satData)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
