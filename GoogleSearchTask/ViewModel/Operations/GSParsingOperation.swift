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
        guard let searchBody = fetchedSearchBody() else { return }
        
        print("Parsing", searchBody)
        searchResults = searchBody.map { SearchResult(link: $0) }
        
        if let completion = completion {
            completion()
        }
    }
    
    private func fetchedSearchBody() -> [String]? {
        for operation in dependencies {
            if let networkingOperation = operation as? GSNetworkingOperation {
                return networkingOperation.searchBody
            }
        }
        return nil
    }

}
