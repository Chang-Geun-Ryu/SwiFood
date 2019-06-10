//
//  RatingStarView.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

final class RatingStarView: UIView {
  
  private var ratingButtons = Array<UIButton>()
  private var ratingStar = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
//    configure()
  }
  
  public func configure(initStar: Int) {
    for num in 0...4 {
      ratingButtons.append(UIButton(type: .system))
      
      if num < initStar {
        ratingButtons.last?.setTitle("★", for: .normal)
      } else {
        ratingButtons.last?.setTitle("☆", for: .normal) // ★★★☆☆
      }
      ratingButtons.last?.tag = num
      ratingButtons.last?.addTarget(self, action: #selector(ratingStar(_:)), for: .touchUpInside)
      
      addSubview(ratingButtons.last!)
      
      ratingButtons.last?.translatesAutoresizingMaskIntoConstraints = false
      ratingButtons.last?.topAnchor.constraint(equalTo: topAnchor).isActive = true
      ratingButtons.last?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      
      guard num > 0 else { continue }
      ratingButtons.last?.leadingAnchor.constraint(equalTo: ratingButtons[num - 1].trailingAnchor).isActive = true
      ratingButtons.last?.widthAnchor.constraint(equalTo: ratingButtons[num - 1].widthAnchor).isActive = true
    }
    
    ratingButtons.first?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    ratingButtons.last?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    ratingStar = initStar - 1
  }
  
  @objc private func ratingStar(_ button: UIButton) {
    for num in 0...4 {
      if num <= button.tag {
        ratingButtons[num].setTitle("★", for: .normal)
      } else {
        ratingButtons[num].setTitle("☆", for: .normal)
      }
    }
    
    ratingStar = button.tag
  }
  
  public func getStar() -> String {
    var star = ""
    
    for num in 0...4 {
      if num <= ratingStar {
        star = "★"
      } else {
        star = "☆"
      }
    }
    
    return star
  }
}
