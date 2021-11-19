//
//  GSParsingOperation.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit
import SwiftSoup

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
    
    private func parse(htmlDocument: String) -> [SearchResult]? {
        var links: [SearchResult]? = nil
        
        do {
            let doc = try SwiftSoup.parse(htmlDocument)

            links = try doc.select("a")
                .map    { try $0.attr("href")}
                .filter { $0.hasPrefix("/url?q=") }
                .map    { $0.dropFirst(7) }
                .map    { SearchResult(link: String($0)) }
                .dropLast(2)
            
        } catch Exception.Error(_, let message) {
            AlertManager.shared.presentAlertOnMainThread(title: "Parsing Error", message: message)
        } catch {
            AlertManager.shared.presentAlertOnMainThread(title: "Parsing Error", message: "Unknown error.")
        }
        
        return links
    }

}
