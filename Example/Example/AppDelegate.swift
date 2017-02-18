//
//  AppDelegate.swift
//  Example
//
//  Created by David Ask on 2017-02-18.
//  Copyright © 2017 Formbound AB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}
