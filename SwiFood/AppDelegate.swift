//
//  AppDelegate.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    
    FireBaseOperating.Share.readFoodList()
    
    Thread.sleep(forTimeInterval: 0.5) // launchScreen 1초 showing
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
    
    window?.rootViewController = SplashViewController()
    
    return true
  }
//    func applicationDidFinishLaunching(_ application: UIApplication) {
//        Thread.sleep(forTimeInterval: 2.0)
////        return true
//    }

}

