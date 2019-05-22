//
//  ViewController.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 21/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let startButton = UIButton(type: .system)
  let logoImageView = UIImageView()
  
  var startBtnPos: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    autolayout()
  }
  
  func configure() {
    logoImageView.image = UIImage(named: "forwer")
    logoImageView.alpha = 0.1
    view.addSubview(logoImageView)
    
    startButton.setTitle("Start", for: .normal)
    startButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
    startButton.alpha = 0.1
    startButton.backgroundColor = UIColor(red: 100/255, green: 222/255, blue: 233/255, alpha: 0.7)
    startButton.addTarget(self, action: #selector(presentMainVC(_:)), for: .touchUpInside)
    view.addSubview(startButton)
  }
  
  func autolayout() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    startButton.translatesAutoresizingMaskIntoConstraints = false
    startButton.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
    startBtnPos = startButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor)
    startBtnPos.isActive = true
    startButton.widthAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 0.9).isActive = true
    startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 1.5) {
      self.logoImageView.alpha = 0.9
      self.startButton.layer.cornerRadius = 25
      self.startButton.alpha = 1
      self.startBtnPos.constant += 200
      self.view.layoutIfNeeded()
    }
  }
  
  @objc func presentMainVC(_ sender: UIButton) {
    
//    let navi = UINavigationController(rootViewController: collVC(collectionViewLayout: StretchyHeaderLayout()))
    
    //let navi = UINavigationController(rootViewController: MainVC())
    
//    present(navi, animated: true)
  }
  
  
  
}
