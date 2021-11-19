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
        NetworkManager.shared.fetchSearchBody(for: query) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let searchResultsHTMLString):
                self.searchResultsHTMLString = searchResultsHTMLString
            case .failure(let error):
                AlertManager.shared.presentAlertOnMainThread(title: "Connection error", message: error.rawValue)
            }
            
            self.state = .finished
        }
    }
}
