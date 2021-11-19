//
//  SearchVC+TextFieldDelegate.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 19.11.21.
//

import UIKit

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTapped()
        return true
    }
    
    @objc func updateSearchButtonIsActive() {
        searchButton.isActive = (queryTextField.text?.count ?? 0) > 0 || (searchButton.appearance == .stop)
    }
}
