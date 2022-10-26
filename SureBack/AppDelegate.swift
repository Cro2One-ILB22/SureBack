//
//  AppDelegate.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 24/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        let nav = UINavigationController(rootViewController: viewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }
}
