//
//  MyPageViewController.swift
//  SwiFood
//
//  Created by JinBae Jeong on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
        loginButton.layout.centerY().centerX()
    }
    
    @objc private func signIn(_ sender: UIButton) {
        let loginVC = LoginViewController()
        present(loginVC, animated: true)
    }

}
