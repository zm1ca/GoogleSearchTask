//
//  GSSearchResultCell.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 19.11.21.
//

import UIKit

class GSSearchResultCell: UITableViewCell {
    
    static let reuseID = "SearchResultCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightCyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
