//
//  AppDelegate.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 21/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    Thread.sleep(forTimeInterval: 1) // launchScreen 1초 showing
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: CollVC(collectionViewLayout: StretchyHeaderLayout()))
    
    return true
  }

}

