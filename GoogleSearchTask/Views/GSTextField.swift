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
        
        tintColor               = accentColor
        textColor               = accentColor
        backgroundColor         = .white
        
        placeholder             = placeholderText
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.borderColor       = UIColor.lightGray.cgColor
        layer.borderWidth       = 2
        layer.cornerRadius      = 12
        layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        autocorrectionType      = .no
        autocapitalizationType  = .sentences
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
