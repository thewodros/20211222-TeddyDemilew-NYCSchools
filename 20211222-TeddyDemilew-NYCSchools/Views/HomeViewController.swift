//
//  ViewController.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import UIKit

enum Section {
    case main
}

private typealias TableViewDiffableDataSource = UITableViewDiffableDataSource<Section, School>
private typealias DiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, School>

class HomeViewController: UIViewController, Coordinating {

    struct Model {
        var schools: [School]?
        var error: NetworkError? = nil
    }
    
    var model: Model {
        didSet {
            applyModel()
        }
    }
    
    var coordinator: Coordinator?
    private var dataSource: TableViewDiffableDataSource!
    
    
    // MARK: - UI
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Enter Zip to filter"
        searchBar.keyboardType = .numberPad
        
        let toolBar = UIToolbar()
        toolBar.items = [
                UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancel)),
                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
                UIBarButtonItem(title: "Search", style: UIBarButtonItem.Style.done, target: self, action: #selector(search))
            ]
        toolBar.sizeToFit()

        searchBar.searchTextField.inputAccessoryView = toolBar
        
        return searchBar
    }()
    
    private let tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HomeCustomCell.self, forCellReuseIdentifier: HomeCustomCell.identifier)
        table.separatorColor = .clear
        return table
    }()
    
    // MARK: -
    
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "Schools"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)

        configTableViewDataSource()

        searchBar.delegate = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }

    // MARK: - set up Diffable TableView DataSource & Diffable DataSource Snapshot
    
    private func configTableViewDataSource() {
        dataSource = TableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, school) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCustomCell.identifier, for: indexPath) as? HomeCustomCell
            cell?.nameLabel.text = school.name
            cell?.locationLabel.text = school.details
            return cell
        }
    }
    
    private func updateSnapshot() {
        guard let dataSource = dataSource else { return }
        
        var snapshot = DiffableDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(model.schools ?? [], toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: -
    
    private func applyModel() {
        if let error = model.error {
            show(error: error)
            return
        }
        
        guard let schools = model.schools else {
            return
        }

        if schools.isEmpty {
            showAlert(title: "", message: "No data available.")
        }

        updateSnapshot()
    }

    private func show(error: NetworkError) {
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
        
        showAlert(title: "Error", message: message)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func cancel () {
        searchBar.resignFirstResponder()
    }

    @objc func search () {
        searchBar.resignFirstResponder()
        coordinator?.received(event: .searchSchools(zip: searchBar.text))
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("\(searchBar.text ?? "-")")
        // TODO: fetch schools with this code
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let totalCharacters = (searchBar.text?.appending(text).count ?? 0) - range.length
        return totalCharacters <= 5
    }
}
