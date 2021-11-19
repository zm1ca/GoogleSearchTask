//
//  ViewController.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class SearchVC: UIViewController {
    
    var viewModel: TableViewViewModelType?

    private var isSearching: Bool! {
        didSet {
            if isSearching {
                searchButton.appearance = .stop
                activityIndicator.startAnimating()
            } else {
                searchButton.appearance = .search
                activityIndicator.stopAnimating()
            }
            updateSearchButtonIsActive()
        }
    }
    
    let queryTextField    = GSTextField(placeholderText: "ex: Who is John Doe?", accentColor: .gunmetal)
    let searchButton      = GSSearchButton()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let resultsTableView  = UITableView(frame: .zero, style: .plain)
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightCyan
        layoutUI()
        viewModel = SearchViewModel()
        
        configureHidingKeyboardOnTap()
        configureActions()
        configureResultsTableView()
        
        isSearching = false
        updateSearchButtonIsActive()
    }
    
    
    //MARK: - UI
    private func layoutUI() {
        view.addSubviews(queryTextField, searchButton, resultsTableView, activityIndicator)
        
        let horizontalPaddding: CGFloat = 24
        let verticalPading:     CGFloat = 12
        let verticalInset:      CGFloat = 24
        
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
            resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalInset),
            
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
    private func configureActions() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        queryTextField.addTarget(self, action: #selector(updateSearchButtonIsActive), for: .editingChanged)
    }

    @objc func searchButtonTapped() {
        isSearching.toggle()
        hideKeyboard()
        
        if isSearching {
            viewModel?.fetchSearchResults(for: queryTextField.text!) { [weak self] in
                DispatchQueue.main.async {
                    self?.resultsTableView.reloadData()
                    self?.isSearching = false
                }
            }
        } else {
            viewModel?.cancelAllOperationsOnQueue()
        }
    }
}
