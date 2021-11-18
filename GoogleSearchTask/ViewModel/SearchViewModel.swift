//
//  SearchViewModel.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

class SearchViewModel: TableViewViewModelType {
    
    private let queue = OperationQueue()
    
    private var searchResults: [SearchResult]?
    
    func fetchSearchResults(for query: String, completion: @escaping () -> ()) {
        let networkingOperation = GSNetworkingOperation(query: query)
        
        let parsingOperation = GSParsingOperation()
        parsingOperation.completion = {
            if let searchResults = parsingOperation.searchResults {
                self.searchResults = searchResults
            }
            completion()
        }
        parsingOperation.addDependency(networkingOperation)
        
        queue.addOperations([networkingOperation, parsingOperation], waitUntilFinished: false)
    }
     
    func cancelAllOperationsOnQueue() {
        queue.cancelAllOperations()
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
