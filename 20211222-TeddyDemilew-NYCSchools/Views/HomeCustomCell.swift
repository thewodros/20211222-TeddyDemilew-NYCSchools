//
//  HomeCustomCell.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

class HomeCustomCell: UITableViewCell {
    static let identifier = "HomeCustomCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 4
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(locationLabel)
        contentView.addSubview(stackView)
        contentView.backgroundColor = .white
        backgroundColor = .white //.darkGray
        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.75
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 12, bottom: 3, right: 12))

        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }    
}
