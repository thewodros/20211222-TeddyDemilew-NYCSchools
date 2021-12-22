//
//  MainCoordinator.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navController: UINavigationController?
    private var homeVC: (HomeViewController & Coordinating)!
    private var networkService: NetworkService!
    
    init(rootVC: UINavigationController,
         networkService: NetworkService = SocrataNetworkingClient()) {
        navController = rootVC
        self.networkService = networkService
        homeVC = HomeViewController(model: HomeViewController.Model(schools: []))
        homeVC.coordinator = self
        navController?.viewControllers = [homeVC]
    }
    
    func start() {        
        fetchSchools()
    }
    
    func received(event: Event) {
        switch event {
        case .searchSchools(let zip):
            fetchSchools(zip: zip)
        case .schoolCellSelected(let school):
            openDetailsView(for: school)
        }
    }
}


private extension MainCoordinator {
    func fetchSchools(zip: String? = nil) {
        let zip = zip?.isEmpty == true ? nil : zip
        let request = SchoolsRequest(zip: zip)

        networkService.fetchSchools(for: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schools):
                    self?.homeVC.model = HomeViewController.Model(schools: schools)
                case .failure(let error):
                    self?.homeVC.model = HomeViewController.Model(schools: [],
                                                                  error: error)
                }
            }
        }
    }
    
    func fetchSATData() {
        let request = SatDataRequest(dbn: "01M292")
        
        networkService.fetchSATData(for: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let satData):
                    print("satData: \(satData)")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func openDetailsView(for school: School) {
        print("open details for school: \(school.name ?? "-")")
    }
}
