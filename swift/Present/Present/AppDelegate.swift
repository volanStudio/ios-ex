//
//  AppDelegate.swift
//  Present
//
//  Created by Lucas Smith on 9/18/14.
//  Copyright (c) 2014 Volan Studio, llc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.whiteColor()
        win.rootViewController = UINavigationController(rootViewController: ViewController())
        return win
        }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        window.makeKeyAndVisible()
        return true
    }

}

