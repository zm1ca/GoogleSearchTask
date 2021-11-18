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
                self.presentAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue)
            }
            
            self.state = .finished
        }
    }
    
    //Probably doesn't belong here
    private func presentAlertOnMainThread(title: String, message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                alertVC.dismiss(animated: true)
            }))
        
            guard let visibleViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController else { return }
            visibleViewController.present(alertVC, animated: true)
        }
    }
}
