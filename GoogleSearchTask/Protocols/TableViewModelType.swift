//
//  TableViewModelType.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

protocol TableViewViewModelType {
    
    func numberOfRows() -> Int
    func text(forCellAt indexPath: IndexPath) -> String
    func fetchSearchResults(for query: String, completion: @escaping () -> ())
}
