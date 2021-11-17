//
//  SearchViewModel.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

class SearchViewModel: TableViewViewModelType {
    
    private let queue = OperationQueue()
    
    private var networkManager = NetworkManager()
    
    private var searchResults: [SearchResult]?
    
    func fetchSearchResults(for query: String, completion: @escaping () -> ()) {
        //Fetching google's response for query
        let networkingOperation = BlockOperation {
            NetworkManager.fetchSearchBody(for: query) { [weak self] searchResults in
                guard let self = self else { return }
                self.searchResults = searchResults.map { SearchResult(link: $0) }
            }
        }
        
        //Parsing response to fill searchResults
        let parsingOperation = BlockOperation {
            print("Parsing")
        }
        parsingOperation.addDependency(networkingOperation)
        
        //Calling completion block
        let completionOperation = BlockOperation(block: completion)
        completionOperation.addDependency(parsingOperation)
        
        
        queue.addOperations([networkingOperation, parsingOperation, completionOperation], waitUntilFinished: false )
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
