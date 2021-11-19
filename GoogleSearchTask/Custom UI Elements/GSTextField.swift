//
//  GSTextField.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class GSTextField: UITextField {

    convenience init(placeholderText: String, accentColor: UIColor) {
        self.init(frame: .zero)
        tintColor   = accentColor
        textColor   = accentColor
        placeholder = placeholderText
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor        = .lightCyan
        layer.borderColor      = UIColor.bdazzledBlue.cgColor
        layer.borderWidth      = 2
        layer.cornerRadius     = 12
    
        autocorrectionType     = .no
        autocapitalizationType = .sentences
        returnKeyType          = .google
        clearButtonMode        = .always
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Insets
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
