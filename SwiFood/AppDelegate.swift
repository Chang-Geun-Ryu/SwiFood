//
//  AppDelegate.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    public var loginViewController: LoginViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
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
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        loginViewController.sign(signIn!, didSignInFor: user, withError: error)
    }
    
    @nonobjc func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                         withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        
        if let clintID = signIn.clientID {
            print("AppDelegate:signIn:clintID : \(clintID)")
        }
    }
}

