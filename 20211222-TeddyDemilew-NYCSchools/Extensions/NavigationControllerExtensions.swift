//
//  NavigationControllerExtensions.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation
import UIKit

extension UINavigationController {
    func appNavBarStyle(with tintColor: UIColor = .white) {
        navigationBar.barTintColor = tintColor
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
    }
}
