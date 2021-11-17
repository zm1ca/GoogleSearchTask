//
//  ViewController.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchResults: [String] = ["first", "second", "third"]
    
    private var isSearching: Bool! {
        didSet {
            if isSearching {
                searchButton.appearance = .stop
                activityIndicator.startAnimating()
            } else {
                searchButton.appearance = .search
                activityIndicator.stopAnimating()
            }
        }
    }
    
    private let queryTextField    = GSTextField(placeholderText: "Who is John Doe?", accentColor: .GSDarkSky)
    private let searchButton      = GSSearchButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let resultsTableView  = UITableView(frame: .zero, style: .plain)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        
        configureHidingKeyboardOnTap()
        configureButtonActions()
        configureResultsTableView()
        
        isSearching = false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    
    //MARK: - UI
    private func layoutUI() {
        view.addSubviews(queryTextField, searchButton, resultsTableView, activityIndicator)
        
        let horizontalPaddding: CGFloat = 8
        let verticalPading:     CGFloat = 8
        let verticalInset:      CGFloat = 16
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalInset),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPaddding),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPaddding),
            queryTextField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: queryTextField.bottomAnchor, constant: verticalPading),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPaddding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPaddding),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultsTableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: verticalPading),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPaddding),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPaddding),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalInset),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    //MARK: - Configure Text Field
    private func configureHidingKeyboardOnTap() {
        queryTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    //MARK: - Configure Button
    private func configureButtonActions() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc private func searchButtonTapped() {
        isSearching.toggle()
        hideKeyboard()
        print("Perform search")
    }
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTapped()
        return true
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func configureResultsTableView() {
        resultsTableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: Constants.searchResultsCellReuseID)
        resultsTableView.delegate   = self
        resultsTableView.dataSource = self
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(
            withIdentifier: Constants.searchResultsCellReuseID,
            for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    
}
