//
//  SignUpViewController.swift
//  SwiFood
//
//  Created by JinBae Jeong on 17/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let signUpTitle: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    let signUpFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let nickName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = #imageLiteral(resourceName: "user")
        imageView.image = image
        textField.leftView = imageView
        
        return textField
    }()
    
    let userEmail: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        
        return textField
    }()
    
    let userPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    let completeSignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6117647059, green: 0.2, blue: 0.2588235294, alpha: 1)
        button.tintColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        dismissButton.addTarget(self, action: #selector(dismissButton(_:)), for: .touchUpInside)
        
        configure()
    }
    
    private func configure() {
        
        view.addSubview(dismissButton)
        view.addSubview(signUpTitle)
        view.addSubview(signUpFieldView)
        signUpFieldView.addSubview(profileImageView)
        signUpFieldView.addSubview(nickName)
        signUpFieldView.addSubview(userPassword)
        view.addSubview(completeSignUpButton)
        
        autoLayout()
        
        completeSignUpEvent()
    }
    
    private func signUpField() {
        
    }
    
    private func completeSignUpEvent() {
        completeSignUpButton.addTarget(self, action: #selector(completeSignUp(_:)), for: .touchUpInside)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        dismissButton.layout.top(equalTo: signUpTitle.topAnchor).trailing(equalTo: view.trailingAnchor, constant: -30)
        signUpTitle.layout.top(equalTo: guide.topAnchor, constant: 10).centerX()
        signUpFieldView.top(equalTo: signUpTitle.bottomAnchor, constant: 10)
        nickName.layout.centerX().centerY(equalTo: guide.centerYAnchor, constant: -200)
        completeSignUpButton.layout.bottom(equalTo: guide.bottomAnchor, constant: -10).leading(equalTo: guide.leadingAnchor, constant: 30).trailing(equalTo: guide.trailingAnchor, constant: -30)
        
        signUpFieldView.topAnchor.constraint(equalTo: signUpTitle.bottomAnchor, constant: 10).isActive = true
        signUpFieldView.bottomAnchor.constraint(equalTo: completeSignUpButton.topAnchor, constant: 10).isActive = true
        signUpFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        signUpFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        completeSignUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc private func dismissButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func completeSignUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (user, error) in
            if let error = error {
                print("Failed to create user with error: ", error.localizedDescription)
                return
            }
            
            // success
            print("Successfully created with Firebase")
        }
        dismiss(animated: true)
    }

}
