//
//  AppDelegate.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return .portrait
        default: return .all
        }
    }

}

