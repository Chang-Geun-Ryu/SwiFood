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

class CollectionHeaderView: UICollectionReusableView {
  let pageControl = UIPageControl()
  let scrollView = UIScrollView()
  
  let imageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "Header"))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  var foodImageViews: [UIImageView] = []
  var currentImage = 0
  
  var timer = Timer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(scrollView)
//    scrollView.fillSuperview()
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    setupImageViews(imageCount: 5)
    
    pageControl.numberOfPages = 5
    pageControl.currentPage = 0
    pageControl.hidesForSinglePage = true
    
    scrollView.delegate = self
    scrollView.isPagingEnabled = true
    
    addSubview(pageControl)
    
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    setupTimer()
  }
  
  deinit {
    timer.fire()  // scheduledTimer 해제
  }
  
  func setupTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] (_) in
      guard let `self` = self else { return }
      
      self.nextFoodShowing()
    })
  }
  
  // 5초에 한번 호출
  func nextFoodShowing() {
    let xPos = pageControl.currentPage < pageControl.numberOfPages - 1 ? scrollView.contentOffset.x + frame.width : 0
    scrollView.setContentOffset(CGPoint(x: xPos, y: scrollView.contentOffset.y), animated: true)
  }
  
  func setupImageView() {
    let imageViewFirst = UIImageView(image: UIImage(named: "MainApplePie"))
    imageViewFirst.contentMode = .scaleAspectFill
    imageViewFirst.clipsToBounds = true
    scrollView.addSubview(imageViewFirst)
    
    let imageViewSecond = UIImageView(image: UIImage(named: "MainChocolate"))
    imageViewSecond.contentMode = .scaleAspectFill
    imageViewSecond.clipsToBounds = true
    scrollView.addSubview(imageViewSecond)
  }
  
  func setupImageViews(imageCount: Int) {
    for num in 0..<imageCount {
      foodImageViews.append(UIImageView(image: UIImage(named: "ApplePieMain")))
      foodImageViews.last?.contentMode = .scaleAspectFill
      foodImageViews.last?.clipsToBounds = true
      foodImageViews.last?.backgroundColor = .red
      
      scrollView.addSubview(foodImageViews.last!)
      
      foodImageViews.last?.translatesAutoresizingMaskIntoConstraints = false
      foodImageViews.last?.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
      foodImageViews.last?.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
      foodImageViews.last?.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
      foodImageViews.last?.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
      
      if foodImageViews.count > 1 {
        foodImageViews[num - 1].trailingAnchor.constraint(equalTo: foodImageViews[num].leadingAnchor).isActive = true
        foodImageViews[num].leadingAnchor.constraint(equalTo: foodImageViews[num - 1].trailingAnchor).isActive = true
      }
    }
    
    foodImageViews.first?.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    foodImageViews.last?.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
  }
  
  func setMainImage() {
    for num in 0..<foodImageViews.count{
      guard let image = CollVC.food.images[CollVC.food.list[num].iconImage] as? UIImage
        else {
          print("fail header")
          return
      }
      
      foodImageViews[num].image = image
    }
  }
  
  func setupGesture() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
    tap.numberOfTapsRequired = 1
    tap.numberOfTouchesRequired = 1
    addGestureRecognizer(tap)
  }
  
  @objc func tapGesture(_ gesture: UIGestureRecognizer) {
    guard let tapGesture = gesture as? UITapGestureRecognizer else { return }
    guard tapGesture.state == UITapGestureRecognizer.State.ended else { return }
    NotificationCenter.default.post(name: .headerTap, object: nil, userInfo: ["currentImage": pageControl.currentPage])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func getSelf() -> CollectionHeaderView {
    return self
  }
}


extension CollectionHeaderView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(frame.width)
  }
}

extension CollectionHeaderView: HeaderStrechy {
  func strechyFrame(offsetY: CGFloat) {
    
  }
}
