//
//  AppDelegate.swift
//  NYTimes
//
//  Created by MAC on 12/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UINavigationController(rootViewController: ArticalViewController.instantiateFromNib()!)
        return true
        
    }

}

