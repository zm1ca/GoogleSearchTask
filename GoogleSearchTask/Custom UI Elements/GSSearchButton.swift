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

    override init(frame: CGRect) {
        appearance = .search
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        updateAppearance()
        setTitleColor(.GSDarkSky, for: .normal)
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAppearance() {
        switch appearance {
        case .search:
            backgroundColor = .systemGreen
            setTitle("Google Search", for: .normal) //fancy attributed string?
        case .stop:
            backgroundColor = .systemRed
            setTitle("Stop", for: .normal)
        }
    }
    
}

enum SearchButtonAppearance {
    case search, stop
}
