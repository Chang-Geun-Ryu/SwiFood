//
//  MyPageViewController.swift
//  SwiFood
//
//  Created by JinBae Jeong on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class MyPageViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "로그인상태"
        
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            view.addSubview(loginButton)
            loginButton.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
            loginButton.layout.centerY().centerX()
        } else {
            view.addSubview(logoutButton)
            logoutButton.addTarget(self, action: #selector(signOut(_:)), for: .touchUpInside)
            logoutButton.layout.centerY().centerX()
        }
        
        view.addSubview(label)
        label.layout.centerX().top()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("@@@@", Auth.auth().currentUser)
        
        if Auth.auth().currentUser == nil {
            label.text = "로그아웃 했습니다."
            view.addSubview(loginButton)
            loginButton.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
            loginButton.layout.centerY().centerX()
            logoutButton.isHidden = true
            loginButton.isHidden = false
        } else {
            label.text = "로그인 중입니다."
            view.addSubview(logoutButton)
            logoutButton.addTarget(self, action: #selector(signOut(_:)), for: .touchUpInside)
            logoutButton.layout.centerY().centerX()
            logoutButton.isHidden = false
            loginButton.isHidden = true
        }
    }
    
    private func myPageView() {
        
    }
    
    @objc private func signIn(_ sender: UIButton) {
        let loginVC = LoginViewController()
        present(loginVC, animated: true)
    }
    
    @objc private func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        // create the alert
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            do {
                try GIDSignIn.sharedInstance().signOut()
                try firebaseAuth.signOut()
                print("signOut success")
                
                self.view.layoutIfNeeded()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            let tabbar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
            tabbar?.selectedIndex = 0
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }

}
