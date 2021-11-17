//
//  ViewController.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class SearchVC: UIViewController {
    
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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        
        configureHidingKeyboardOnTap()
        configureButtonActions()
        
        isSearching = false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    
    //MARK: - UI
    private func layoutUI() {
        
        view.addSubviews(queryTextField, searchButton, activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            queryTextField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: queryTextField.bottomAnchor, constant: 8),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            
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
