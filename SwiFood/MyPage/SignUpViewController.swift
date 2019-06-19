//
//  SignUpViewController.swift
//  SwiFood
//
//  Created by JinBae Jeong on 17/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    var imageSelected = false
    
    var profileImage = UIImage(named: "")
    var profileImageName = ""
    let profileimageView = UIImageView(image: UIImage(named: "img"))
    
    var ref: DatabaseReference!
    
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
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let nickName: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "닉네임"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = #imageLiteral(resourceName: "user")
        imageView.image = image
        tf.leftView = imageView
        
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = #imageLiteral(resourceName: "email")
        imageView.image = image
        tf.leftView = imageView
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = #imageLiteral(resourceName: "icons8-lock-filled-50")
        imageView.image = image
        tf.leftView = imageView
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        return tf
    }()
    
    let confimPasswordUserTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = #imageLiteral(resourceName: "icons8-lock-filled-50")
        imageView.image = image
        tf.leftView = imageView
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        return tf
    }()
    
    let completeSignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6117647059, green: 0.2, blue: 0.2588235294, alpha: 1)
        button.tintColor = .white
        button.isEnabled = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
    }
    
    private func configure() {
        
        view.addSubview(dismissButton)
        view.addSubview(signUpTitle)
        view.addSubview(plusPhotoButton)
        view.addSubview(completeSignUpButton)
        
        completeSignUpButton.isEnabled = false
        dismissButton.addTarget(self, action: #selector(dismissButton(_:)), for: .touchUpInside)
        plusPhotoButton.addTarget(self, action: #selector(handleSelectProfilePhoto(_:)), for: .touchUpInside)
        
        autoLayout()
        configureViewComponents()
        completeSignUpEvent()
    }
    
    private func completeSignUpEvent() {
        completeSignUpButton.addTarget(self, action: #selector(completeSignUp(_:)), for: .touchUpInside)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        dismissButton.layout.top(equalTo: signUpTitle.topAnchor).trailing(equalTo: view.trailingAnchor, constant: -30)
        signUpTitle.layout.top(equalTo: guide.topAnchor, constant: 10).centerX()
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.topAnchor.constraint(equalTo: signUpTitle.bottomAnchor, constant: 50).isActive = true
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        completeSignUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        completeSignUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        completeSignUpButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        completeSignUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [nickName, emailTextField, passwordTextField, confimPasswordUserTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
    }
    
    @objc private func dismissButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func handleSelectProfilePhoto(_ sender: UIButton) {
        // configure Image Picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // present image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func formValidation() {
        
        guard
            nickName.hasText,
            emailTextField.hasText,
            passwordTextField.hasText,
            confimPasswordUserTextField.hasText,
            passwordTextField.text == confimPasswordUserTextField.text,
            imageSelected == true else {
                completeSignUpButton.isEnabled = false
                
                return
        }
        
        completeSignUpButton.isEnabled = true
        
    }
    
    @objc private func completeSignUp(_ sender: UIButton) {
        
        // properties
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            // handle error
            if let error = error {
                print("Failed to create user with error: ", error.localizedDescription)
                return
            }
            
            // set profile image
            guard let profileImg = self.plusPhotoButton.imageView?.image else { return }
            
            // upload data
            guard let uploadData = profileImg.jpegData(compressionQuality: 0.3) else { return }
            
            
            // place image in firebase storage
           
            self.ref = Database.database().reference()
            let keyPath = self.ref.child("Profile").childByAutoId()
           
            keyPath.updateChildValues(["nickName":self.nickName.text!])
            keyPath.updateChildValues(["profileImage":self.profileImageName])
            Storage.storage().reference().child("profile_images").child(self.profileImageName).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                // handle error
                if let error = error {
                    print("failed to upload image to Firebase Storage with error.", error.localizedDescription)
                }
                
            })
            
            // success
            print("Successfully created with Firebase")
            
            
            
        }
        let tabbar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
        tabbar?.selectedIndex = 0
        self.dismiss(animated: true)
    }

}

extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // selected image
        guard let profile = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            
            imageSelected = false
            return
            
        }
        
        guard let editData = profile.jpegData(compressionQuality: 0.3) else { return print("editImage")}
        guard let editImage = UIImage(data: editData) else { return }
        let imageName = "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000))"
        
        profileImageName = imageName
        profileImage = editImage
        profileimageView.image = editImage
        
        // set imageSelected to true
        imageSelected = true
        
        // configure plusPhotoBtn with selected image
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(profile.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
