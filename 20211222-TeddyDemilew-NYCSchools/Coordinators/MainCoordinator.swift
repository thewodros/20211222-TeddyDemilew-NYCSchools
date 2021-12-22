//
//  MainCoordinator.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navController: UINavigationController?
    private var homeVC: HomeViewController!
    private var networkService: NetworkService!
    
    init(rootVC: UINavigationController,
         networkService: NetworkService = SocrataNetworkingClient()) {
        navController = rootVC
        self.networkService = networkService
        homeVC = HomeViewController(model: HomeViewController.Model(schools: []))
        navController?.viewControllers = [homeVC]
    }
    
    func start() {        
        fetchSchools()
    }
    
    func received(event: Event) {
        
    }
}


private extension MainCoordinator {
    func fetchSchools() {
        let request = SchoolsRequest(zip: nil)

        networkService.fetchSchools(for: request) { [weak self] result in
            switch result {
            case .success(let schools):
                self?.homeVC.model = HomeViewController.Model(schools: schools)
            case .failure(let error):
                self?.homeVC.model = HomeViewController.Model(schools: [],
                                                              error: error)
            }
        }
    }
    
    func fetchSATData() {
        let request = SatDataRequest(dbn: "01M292")
        
        networkService.fetchSATData(for: request) { result in
            switch result {
            case .success(let satData):
                print("satData: \(satData)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
