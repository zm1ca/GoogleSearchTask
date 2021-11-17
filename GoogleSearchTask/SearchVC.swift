//
//  ViewController.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class SearchVC: UIViewController {
    
    private let queryTextField = GSTextField(placeholderText: "Who is John Doe?", accentColor: .GSDarkSky)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHidingKeyboardOnTap()
        layoutUI()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    
    //MARK: - UI
    private func layoutUI() {
        view.addSubviews(queryTextField)
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            queryTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK: - Configurations
    private func configureHidingKeyboardOnTap() {
        queryTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}
