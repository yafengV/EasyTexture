//
//  AppDelegate.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = .init(frame: UIScreen.main.bounds)
        let nvc = UINavigationController(rootViewController: ViewController())
        if #available(iOS 13.0, *) {
            nvc.navigationBar.scrollEdgeAppearance = .init()
            nvc.navigationBar.standardAppearance = .init()
        }
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        return true
    }


}

