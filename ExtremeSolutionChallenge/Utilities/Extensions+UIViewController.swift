//
//  Extensions+UIViewController.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import Foundation
import UIKit
import ProgressHUD

extension UIViewController {
    func customPresent(vc: UIViewController) {
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
    func showAlert(message: String) {
        var alert: UIAlertController = UIAlertController()
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showLoading() {
        ProgressHUD.show()
    }
    
    func hideLoading() {
        ProgressHUD.dismiss()
    }

}
