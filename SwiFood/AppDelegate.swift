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

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            print("success")
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
        })
        
    }
    
    // GIDSignIn 인스턴스의 handleURL 메소드를 호출하며 이 메소드는 애플리케이션이 인증 절차가 끝나고 받는 URL를 적절히 처리
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: [:]
        )
    }
    
    // iOS 8 이상부터 지원할 경우 사용
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {    return GIDSignIn.sharedInstance().handle(
        url,
        sourceApplication: sourceApplication,
        annotation: annotation
        )
    }
    
  var window: UIWindow?


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

}

