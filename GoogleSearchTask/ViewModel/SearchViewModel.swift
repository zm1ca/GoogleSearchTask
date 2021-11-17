//
//  SearchViewModel.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

class SearchViewModel: TableViewViewModelType {
    
    private var networkManager = NetworkManager()
    
    private var searchResults: [SearchResult]?
    
    func fetchSearchResults(for query: String, completion: @escaping () -> ()) {
        //TODO: Switch to Operation Queue (1. network, 2. parse, 3. completion
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            NetworkManager.fetchSearchBody(for: query) { [weak self] searchResults in
                guard let self = self else { return }
                self.searchResults = searchResults.map { SearchResult(link: $0) }
                completion()
            }
        }
    }
    
    func numberOfRows() -> Int {
        return searchResults?.count ?? 0
    }
    
    func text(forCellAt indexPath: IndexPath) -> String {
        guard let searchResults = searchResults else { return "" }
        let searchResult = searchResults[indexPath.row]
        return searchResult.link
    }
}
