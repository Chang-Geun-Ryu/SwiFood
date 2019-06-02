//
//  UploadAnimationVC.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 02/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class UploadAnimationVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}



class LoadingHUD: NSObject {
  private static let sharedInstance = LoadingHUD()
  private var popupView: UIImageView?
  
  class func show() {
    let popupView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))//CGRectMake(0, 0, 300, 300))
    popupView.backgroundColor = .black
    popupView.animationImages = LoadingHUD.getAnimationImageArray()
    popupView.animationDuration = 4.0
    popupView.animationRepeatCount = 0
    
    if let window = UIApplication.shared.keyWindow { //.sharedApplication().keyWindow {
      window.addSubview(popupView)
      popupView.center = window.center
      popupView.startAnimating()
      sharedInstance.popupView?.removeFromSuperview()
      sharedInstance.popupView = popupView
    }
  }
  
  class func hide() {
    if let popupView = sharedInstance.popupView {
      popupView.stopAnimating()
      popupView.removeFromSuperview()
    }
  }
  
  private class func getAnimationImageArray() -> [UIImage] {
    var animationArray: [UIImage] = []
    animationArray.append(UIImage(named: "day_1")!)
    animationArray.append(UIImage(named: "day_2")!)
    animationArray.append(UIImage(named: "day_3")!)
    animationArray.append(UIImage(named: "day_4")!)
    
    return animationArray
  }
}
