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
    private lazy var homeVC: (HomeViewController & Coordinating)! = {
        let homeVC = HomeViewController(model: HomeViewController.Model(schools: []))
        homeVC.coordinator = self
        return homeVC
    }()
    private lazy var satDataDetailsVC: (SatDataDetailsViewController & Coordinating)! = {
        let satDataDetailsVC = SatDataDetailsViewController(model: SatDataDetailsViewController.Model())
        satDataDetailsVC.coordinator = self
        return satDataDetailsVC
    }()
    private lazy var mapVC: MapViewController! = {
        return MapViewController()
    }()
    
    init(rootVC: UINavigationController,
         networkService: NetworkService = SocrataNetworkingClient()) {
        navController = rootVC
        self.networkService = networkService
        //homeVC.coordinator = self
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
        case .openMap(let lat, let lng, let schoolName):
            openMap(lat: lat, lng: lng, schoolName: schoolName)
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
    
    func fetchSATData(for dbn: String ) {
        let request = SatDataRequest(dbn: dbn)
        
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
        fetchSATData(for: school.dbn)
        self.navController?.pushViewController(satDataDetailsVC, animated: true)
    }
    
    func openMap(lat: Double, lng: Double, schoolName: String) {
        mapVC.lat = lat
        mapVC.lng = lng
        mapVC.schoolName = schoolName
        self.navController?.pushViewController(mapVC, animated: true)
    }
}
