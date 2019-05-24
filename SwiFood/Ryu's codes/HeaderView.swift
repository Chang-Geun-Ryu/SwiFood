//
//  HeaderView.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

extension Notification.Name {
  static let headerTap = Notification.Name("TapHeader")
}

class HeaderView: UICollectionReusableView {
  
  let imageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "Header"))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let images = ["MainApplePie", "MainChocolate", "MainDessert", "MainGrapePizza", "MainTarte"]

  var currentImage = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
    
    imageView.fillSuperview()
    
    setupGesture()
  }
  
  func setupGesture() {
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
    swipeRight.direction = .right
    addGestureRecognizer(swipeRight)
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
    swipeLeft.direction = .left
    addGestureRecognizer(swipeLeft)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
    tap.numberOfTapsRequired = 1
    tap.numberOfTouchesRequired = 1
    addGestureRecognizer(tap)
  }
  
  @objc func tapGesture(_ gesture: UIGestureRecognizer) {
    guard let tapGesture = gesture as? UITapGestureRecognizer else { return }
    guard tapGesture.state == UITapGestureRecognizer.State.ended else { return }
    NotificationCenter.default.post(name: .headerTap, object: nil, userInfo: ["currentImage": currentImage])
  }
  
  @objc func swipeGesture(_ gesture: UIGestureRecognizer) {
    guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
    
    switch swipeGesture.direction {
    case UISwipeGestureRecognizer.Direction.left:
      if currentImage == CollVC.food.list.count - 1 {
        currentImage = 0
      } else {
        currentImage += 1
      }
      guard let image = CollVC.food.images[CollVC.food.list[currentImage].iconImage] as? UIImage else {print("fail header"); return  }
      imageView.image = image //UIImage(named: images[currentImage])
    case UISwipeGestureRecognizer.Direction.right:
      if currentImage == 0 {
        currentImage = CollVC.food.list.count - 1
      } else {
        currentImage -= 1
      }
      guard let image = CollVC.food.images[CollVC.food.list[currentImage].iconImage] as? UIImage else {print("fail header"); return  }
      imageView.image = image //UIImage(named: images[currentImage])
    default:
      break
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
