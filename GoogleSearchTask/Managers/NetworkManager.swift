//
//  NetworkManager.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

class NetworkManager: NSObject {
    
    static func fetchSearchBody(for query: String, completion: ([String]) -> ()) {
        //TODO: It is meant to return just a string to parse
        sleep(2)
        completion(["Link 1" + query, "Link 2", "Link 3"])
    }
}
