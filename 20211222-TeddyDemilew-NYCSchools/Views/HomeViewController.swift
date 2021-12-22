//
//  ViewController.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class HomeViewController: UIViewController {

    struct Model {
        var schools: [School]?
        var error: NetworkError? = nil
    }
    
    var model: Model {
        didSet {
            applyModel()
        }
    }
    
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    
}

private extension HomeViewController {
    func applyModel() {
        if let error = model.error {
            show(error: error)
            return
        }
        
        guard let schools = model.schools else {
            return
        }

        print("Number of schools: \(schools.count)")
    }

    func show(error: NetworkError) {
        var message: String
        switch error {
        case .badURL:
            message = "Bad URL"
        case .badRequest:
            message = "Bad Request"
        case .noData:
            message = "There is no data."
        case .decodingError:
            message = "Data decoding error."
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
