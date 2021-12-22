//
//  Coordinator.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

enum Event {
    
}

protocol Coordinator {
    var navController: UINavigationController? { get set }
    
    func start()
    func received(event: Event)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
