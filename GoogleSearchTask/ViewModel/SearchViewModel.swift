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
        //1. Networking
        let networkingOperation = GSNetworkingOperation(query: query)
        
        //2. Parsing
        let parsingOperation = GSParsingOperation()
        parsingOperation.addDependency(networkingOperation)
        
        //3. Managing results
        let completionOperation = BlockOperation {
            if let searchResults = parsingOperation.searchResults {
                self.searchResults = searchResults
            }
            completion()
        }
        completionOperation.addDependency(parsingOperation)
        
        queue.addOperations([networkingOperation, parsingOperation, completionOperation], waitUntilFinished: false)
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
