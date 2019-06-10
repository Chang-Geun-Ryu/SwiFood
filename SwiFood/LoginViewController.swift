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

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.tintColor = .black
        
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
        view.addSubview(dismissButton)
        GIDSignIn.sharedInstance().uiDelegate = self
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            
            print("user id : ", uid)
            print("user email : ", email
            )
        }
    }
    
    private func configure() {
        googleSignInButton.addTarget(self, action: #selector(googleSignIn(_:)), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissButton(_:)), for: .touchUpInside)
        autoLayout()
    }
    
    private func autoLayout() {
//        googleSignInButton.layout.centerX().top(equalTo: view.topAnchor, constant: 150)
        
        // 기본 구글 계정 로그인으로 사용할 경우 아래 코드 주석
        googleSignInButton.layout.centerX().top(equalTo: view.bottomAnchor, constant: -200)
        googleSignInButton.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
        googleSignInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        dismissButton.layout.top().trailing(equalTo: view.trailingAnchor, constant: -50)
    }
    
    @objc private func dismissButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func googleSignIn(_ sender: GIDSignInButton) {
        // 기본 구글 계정 로그인으로 사용할 경우 아래 코드 주석
        GIDSignIn.sharedInstance().signIn()
    }
    
    
}

