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
        layoutUI()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    
    //MARK: - Configurations
    private func layoutUI() {
        view.addSubviews(queryTextField)
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            queryTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

