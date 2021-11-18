//
//  GSNetworkingOperation.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class GSNetworkingOperation: AsyncOperation {
    
    var query: String
    var searchResultsHTMLString: String?
    
    init(query: String) {
        self.query = query
        super.init()
      }
    
    override func main() {
        NetworkManager.shared.fetchSearchBody(for: query) { [weak self] searchResultsHTMLString in
            guard let self = self else { return }
            self.searchResultsHTMLString = searchResultsHTMLString
            self.state = .finished
        }
    }

}
