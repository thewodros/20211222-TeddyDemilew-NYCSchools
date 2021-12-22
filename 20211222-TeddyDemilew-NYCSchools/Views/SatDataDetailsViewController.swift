//
//  SatDataDetailsViewController.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit


class SatDataDetailsViewController: UIViewController, Coordinating {
    
    struct Model {
        var isLoading: Bool = false
        var school: School?
        var satData: [SatData]?
        var error: NetworkError? = nil
    }
    
    var model: Model {
        didSet {
            applyModel()
        }
    }
    
    var coordinator: Coordinator?
     
    // MARK: -

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let schoolDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 4
        return label
    }()
    
    let schoolOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let schoolTenthSeatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)        
        label.numberOfLines = 0
        return label
    }()

    let numSatTakersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let mathScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let readingScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let writingScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    // TODO: replace this static text with UIActivityIndicator
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Loading ..."
        return label
    }()

    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: -
    
    init(model: Model = .init()) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().appColor
        title = "SAT Date"
        view.addSubview(container)
        container.addSubview(stackView)
        stackView.addArrangedSubview(loadingLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(schoolTenthSeatLabel)
        stackView.addArrangedSubview(numSatTakersLabel)
        stackView.addArrangedSubview(mathScoreLabel)
        stackView.addArrangedSubview(readingScoreLabel)
        stackView.addArrangedSubview(writingScoreLabel)
        stackView.addArrangedSubview(schoolOverviewLabel)
        stackView.addArrangedSubview(schoolDetailsLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        //stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 12).isActive = true
        stackView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -12).isActive = true
    }
    
    func applyModel() {
        guard model.isLoading == false else {
            return
        }
        
        loadingLabel.isHidden = true
        
        //nameLabel.text = model.school?.name
        nameLabel.text = model.satData?.first?.schoolName

        schoolTenthSeatLabel.text = "SCHOOL 10th SEAT: \(model.school?.tenthSeats ?? "NA")"

        numSatTakersLabel.text = "NUMBER OF SAT TEST TAKERS: \(model.satData?.first?.numberOfSatTakers ?? "NA")"
        
        mathScoreLabel.text = "MATH AVE SCORE: \(model.satData?.first?.mathScore ?? "NA")"
        
        readingScoreLabel.text = "CRITICAL READING AVE SCORE: \(model.satData?.first?.readingScore ?? "NA")"
        
        writingScoreLabel.text = "WRITING AVE SCORE: \(model.satData?.first?.writingScore ?? "NA")"
        
        schoolOverviewLabel.text = "SCHOOL OVERVIEW\n\(model.school?.overview ?? "")"
        schoolOverviewLabel.isHidden = model.school?.overview == nil
        
        schoolDetailsLabel.text = model.school?.details        
    }
}
