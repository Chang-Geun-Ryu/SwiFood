//
//  dataLoadTest.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class dataLoadTest: UIViewController {
  
  let iconImageView = UIImageView()
  let meterialImageViewFirst = UIImageView()
  let meterialImageviewSecond = UIImageView()
  let textview = UITextView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    iconImageView.contentMode = .scaleAspectFill
    iconImageView.clipsToBounds = true
    meterialImageViewFirst.contentMode = .scaleAspectFill
    meterialImageViewFirst.clipsToBounds = true
    meterialImageviewSecond.contentMode = .scaleAspectFill
    meterialImageviewSecond.clipsToBounds = true
    view.addSubview(iconImageView)
    view.addSubview(meterialImageViewFirst)
    view.addSubview(meterialImageviewSecond)
    view.addSubview(textview)
    
    textview.text = "aa"
    
    autolayout()
  }
  
  func autolayout() {
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    iconImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    iconImageView.trailingAnchor.constraint(equalTo: meterialImageViewFirst.leadingAnchor).isActive = true
    iconImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 3).isActive = true
    iconImageView.heightAnchor.constraint(equalToConstant: view.frame.width / 3).isActive = true
    
    meterialImageViewFirst.translatesAutoresizingMaskIntoConstraints = false
    meterialImageViewFirst.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    meterialImageViewFirst.widthAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true
    meterialImageViewFirst.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
    meterialImageViewFirst.trailingAnchor.constraint(equalTo: meterialImageviewSecond.leadingAnchor).isActive = true
    
    meterialImageviewSecond.translatesAutoresizingMaskIntoConstraints = false
    meterialImageviewSecond.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    meterialImageviewSecond.widthAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true
    meterialImageviewSecond.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
    meterialImageviewSecond.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    
    textview.translatesAutoresizingMaskIntoConstraints = false
    textview.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 50).isActive = true
    textview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    textview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    textview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
}
