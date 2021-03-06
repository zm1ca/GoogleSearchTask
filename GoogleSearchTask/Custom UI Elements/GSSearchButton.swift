//
//  GSSearchButton.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class GSSearchButton: UIButton {
    
    var appearance: SearchButtonAppearance {
        didSet { updateAppearance() }
    }
    
    var isActive: Bool {
        didSet { updateAlpha() }
    }

    override init(frame: CGRect) {
        appearance = .search
        isActive   = false
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        updateAppearance()
        
        setTitleColor(.gunmetal, for: .normal)
        layer.borderColor  = UIColor.bdazzledBlue.cgColor
        layer.borderWidth  = 2
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAppearance() {
        switch appearance {
        case .search:
            backgroundColor = .palCerulean
            setTitle("Google Search", for: .normal)
        case .stop:
            backgroundColor = .burntSienna
            setTitle("Stop", for: .normal)
        }
    }
    
    func updateAlpha() {
        if isActive {
            alpha = 1
            isEnabled = true
        } else {
            alpha = 0.5
            isEnabled = false
        }
    }
    
}

enum SearchButtonAppearance {
    case search, stop
}
