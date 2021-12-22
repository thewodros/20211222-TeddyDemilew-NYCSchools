//
//  MainCoordinator.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navController: UINavigationController?
    private var networkService: NetworkService!
    private var homeVC: (HomeViewController & Coordinating)! = {
        return HomeViewController(model: HomeViewController.Model(schools: []))
    }()
    private lazy var satDataDetailsVC: (SatDataDetailsViewController & Coordinating)! = {
        return SatDataDetailsViewController(model: SatDataDetailsViewController.Model())
    }()
    
    init(rootVC: UINavigationController,
         networkService: NetworkService = SocrataNetworkingClient()) {
        navController = rootVC
        self.networkService = networkService
        homeVC.coordinator = self
        navController?.viewControllers = [homeVC]
    }
    
    func start() {
        navController?.appNavBarStyle()
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
        
        networkService.fetchSATData(for: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let satData):
                    self?.satDataDetailsVC.model.satData = satData
                case .failure(let error):
                    self?.satDataDetailsVC.model.error = error
                }
                self?.satDataDetailsVC.model.isLoading = false
            }
        }
    }
    
    func openDetailsView(for school: School) {
        satDataDetailsVC.model.isLoading = true
        satDataDetailsVC.model.school = school
        fetchSATData()
        self.navController?.pushViewController(satDataDetailsVC, animated: true)
    }
}
