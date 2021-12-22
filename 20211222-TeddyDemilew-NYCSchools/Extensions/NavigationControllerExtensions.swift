//
//  NavigationControllerExtensions.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation
import UIKit

extension UINavigationController {
    func appNavBarStyle() {
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
