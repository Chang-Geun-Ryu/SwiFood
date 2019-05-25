//
//  SplashViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "main")
        return imageView
    }()
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SwiFood"
        label.textColor = .white
        label.textAlignment = .center
        label.font =  UIFont(name: "Palatino", size: 40)
        label.alpha = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("splash")
        autolayout()
        // label의 알파를 천천히 바꾸는 거
        UIView.animate(withDuration: 3) { [weak label = self.label] in
            label?.alpha = 1
        }
        // 3초 뒤에 뷰 컨트롤러를 띄우는거
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
            let tapbar = UITabBarController()
            let navi = UINavigationController(rootViewController: CollVC(collectionViewLayout: StretchyHeaderLayout()))
            navi.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
            
            
            let testVC = FirebaseTestVC()
            testVC.tabBarItem = UITabBarItem(title: "Recipe", image: UIImage(named: "chef"), tag: 1)
            tapbar.setViewControllers([navi, testVC], animated: true)
            
            tapbar.tabBar.tintColor = .gray
            appDelegate.window?.rootViewController = tapbar
        }
    }
    
    func autolayout(){
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
}