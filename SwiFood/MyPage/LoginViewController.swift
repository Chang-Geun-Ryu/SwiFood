//
//  LoginViewController.swift
//  SwiFood
//
//  Created by JinBae Jeong on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    let emailSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이메일로 로그인", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6129125831, blue: 0.224805915, alpha: 1)
        button.tintColor = .white
        
        return button
    }()
    
//    let googleSignInButton: GIDSignInButton = {
//        let button = GIDSignInButton()
//
//        return button
//    }()
    
    // 기본 구글 계정 로그인으로 사용할 경우 아래 코드 주석처리 후 위에 코드 사용
    let googleSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("구글 계정으로 로그인", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.1960784314, blue: 0.1882352941, alpha: 1)
        button.tintColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        view.addSubview(googleSignInButton)
        view.addSubview(emailSignInButton)
        view.addSubview(dismissButton)
        
        // Google Signin
        GIDSignIn.sharedInstance().uiDelegate = self

        GIDSignIn.sharedInstance().delegate = self
        configure()
    
        
        
        if let user = Auth.auth().currentUser {
            print(user)
            print("로그인중")
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            
            print("user id : ", uid)
            print("user email : ", email)
        }
    }
    
    private func configure() {
        googleSignInButton.addTarget(self, action: #selector(googleSignIn(_:)), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissButton(_:)), for: .touchUpInside)
        emailSignInButton.addTarget(self, action: #selector(emailSignIn(_:)), for: .touchUpInside)
        autoLayout()
    }
    
    private func autoLayout() {
//        googleSignInButton.layout.centerX().top(equalTo: view.topAnchor, constant: 150)
        
        // 기본 구글 계정 로그인으로 사용할 경우 아래 코드 주석
        googleSignInButton.layout.centerX().top(equalTo: view.bottomAnchor, constant: -150)
        googleSignInButton.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
        googleSignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailSignInButton.layout.centerX().bottom(equalTo: googleSignInButton.topAnchor, constant: -10)
        emailSignInButton.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
        emailSignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dismissButton.layout.top().trailing(equalTo: view.trailingAnchor, constant: -50)
    }
    
    @objc private func dismissButton(_ sender: UIButton) {
        if googleSignInButton.isHidden == true {
            googleSignInButton.isHidden = false
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc private func emailSignIn(_ sender: UIButton) {
        if googleSignInButton.isHidden == true {
            print(1111)
        } else {
            googleSignInButton.isHidden = true
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.emailSignInButton.layout.centerX().bottom(equalTo: self.view.bottomAnchor, constant: -150)
            }, completion: nil)
        }
    }
    
    @objc private func googleSignIn(_ sender: GIDSignInButton) {
        // 기본 구글 계정 로그인으로 사용할 경우 아래 코드 주석
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    /// AppDelegate 가져오기
    ////
    /// - Returns: AppDelegate
    func getAppDelegate() -> AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let err = error {
            print("LoginViewController:error = \(err)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            if let err = error {
                print("LoginViewController:error = \(err)")
                return
            }
            
//            if let appDelegate = self.getAppDelegate(){
//                let info = UserInfo(name: user?.nick, email: user?.email, id: user?.email, password: "", joinAddress: "google")
//                appDelegate.addUserProfile(uid: (user?.uid)!, userInfo: info)
//                self.gotoMainViewController(user: info)
//            }
            
            if let user = user{
                let tabbar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
                tabbar?.selectedIndex = 0
                self.dismiss(animated: true)
                return
            }
        }
    }
        
    
}



