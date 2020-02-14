//
//  AppDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Private Properties
    private let window = UIWindow(frame: UIScreen.main.bounds)

    // MARK: - Public Instance Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.rootViewController = SubscribeViewController()
        window.makeKeyAndVisible()
        return true
    }

}

