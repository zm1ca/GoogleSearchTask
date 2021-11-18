//
//  NetworkManager.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

class NetworkManager {
    
    static  let shared  = NetworkManager()
    private let baseURL = "https://www.google.by/search?q="
    private init() { }

    func fetchSearchBody(for query: String, completion: @escaping (String) -> ()) {
        let rawEndpoint = baseURL + query
        guard let endpoint = rawEndpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: endpoint) else {
            //completed(.failure(.invalidQuery))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                //completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data, let htmlString = String(data: data, encoding: .windowsCP1251) else {
                //completed(.failure(.invalidData))
                return
            }
        
            completion(htmlString)
        }
        task.resume()
    }
}
