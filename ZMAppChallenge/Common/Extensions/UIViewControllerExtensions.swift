//
//  UIViewControllerExtensions.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func presentAlert(title: String = "", message: String) {
        let alertController = UIAlertController(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok.generic.title".localized(), style: .default)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
