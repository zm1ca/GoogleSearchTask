//
//  NetworkManager.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 17.11.21.
//

import Foundation

class NetworkManager {
    
    static  let shared  = NetworkManager()
    private let baseURL = "https://www.google.com/search?q="
//    private let baseURL = "https://yandex.by/search/?text="
    private init() { }

    func fetchSearchBody(for query: String, completed: @escaping (Result<String, GSError>) -> Void) {
        let rawEndpoint = baseURL + query
        guard let endpoint = rawEndpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: endpoint) else {
            completed(.failure(.invalidQuery))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data,
                  let htmlString = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .isoLatin1) else {
                completed(.failure(.invalidData))
                return
            }
            
            completed(.success(htmlString))
        }
        task.resume()
    }
}
