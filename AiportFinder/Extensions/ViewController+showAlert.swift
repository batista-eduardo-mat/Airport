//
//  ViewController+showAlert.swift
//  AiportFinder
//
//  Created by Eduardo Batista on 05/05/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completionHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler?()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
