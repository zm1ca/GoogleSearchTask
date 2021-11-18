//
//  GSParsingOperation.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class GSParsingOperation: Operation {
    
    var completion: (() -> ())?
    var searchResults: [SearchResult]?
    
    override func main() {
        if let searchResultsHTMLString = fetchedSearchResultsHTMLString() {
            searchResults = parse(htmlDocument: searchResultsHTMLString)
        }
        
        if let completion = completion {
            completion()
        }
    }
    
    private func fetchedSearchResultsHTMLString() -> String? {
        for operation in dependencies {
            if let networkingOperation = operation as? GSNetworkingOperation {
                return networkingOperation.searchResultsHTMLString
            }
        }
        return nil
    }
    
    private func parse(htmlDocument: String) -> [SearchResult] {
        return ["link", "2", "34324"].map { SearchResult(link: $0) }
    }

}
