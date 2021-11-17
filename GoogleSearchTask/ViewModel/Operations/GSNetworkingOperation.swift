//
//  GSNetworkingOperation.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import UIKit

class GSNetworkingOperation: Operation {
    
    var query: String?
    var searchBody: [String]?
    
    convenience init(query: String) {
        self.init()
        self.query = query
    }
    
    override func main() {
        guard let query = query else { return }
        
        NetworkManager.fetchSearchBody(for: query) { [weak self] searchResults in
            guard let self = self else { return }
            self.searchBody = searchResults
        }
    }

}
