//
//  AppDelegate.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }


}

extension AppDelegate {
    private func setRootVC() {
        let rootVC = HomeVC(nibName: VCs.homeVC, bundle: nil)
        let navigationController = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

