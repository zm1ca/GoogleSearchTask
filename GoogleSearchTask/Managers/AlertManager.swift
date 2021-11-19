//
//  AlertManager.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 19.11.21.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    private init() { }
    
    func presentAlertOnMainThread(title: String, message: String) {
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
