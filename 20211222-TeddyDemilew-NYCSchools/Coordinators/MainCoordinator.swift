//
//  MainCoordinator.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var navController: UINavigationController?
    
    func start() {
        let vc = ViewController()
        navController?.viewControllers = [vc]
    }
    
    func received(event: Event) {
        
    }
}
