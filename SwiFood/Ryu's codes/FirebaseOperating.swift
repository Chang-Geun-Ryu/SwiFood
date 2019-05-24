//
//  FirebaseOperating.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

final class FireBaseOperating {
  
  static let Share = FireBaseOperating()
  
  var ref: DatabaseReference!
  var databaseHandle: DatabaseHandle?
  
  var itemCount = 0
  
  
  init() {
    ref = Database.database().reference()
  }
  
  func itemCounting() {
    itemCount += 1
    ref.child("Total").setValue(itemCount)
  }
  
  func writeFoodList(food: Food) {
//    ref?.child("Foods").observe(, with: { (metadata) in
//     self.ref.child("Foods/\(self.itemCount)/").set
//      self.ref.child("Foods/\(self.itemCount)/title").setValue(food.title)
//    ref?.child("Foods").child("\(itemCount)").updateChildValues(["title": food.title])
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["title": food.title])
    ref?.keepSynced(true)
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["Comment": food.comment])
    let meta = [food.foodMeterial[0].0, food.foodMeterial[0].1]
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["foodMeterial": meta])
    
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["iconImage": food.iconImage])
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["info": food.info])
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["level": food.level])
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["meterialImage": food.meterialImages])
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["recipe": food.recipe])
    ref?.child("Foods").child("\(itemCount)").updateChildValues(["sensitivity": food.sensitivity])
    
//    self.ref.child("Foods/\(self.itemCount)/title") //.setValue(food.title)
//      self.ref.child("Foods/\(self.itemCount)/Comment").setValue(food.comment)
//      self.ref.child("Foods/\(self.itemCount)/foodMeterial").setValue(food.foodMeterial)
//      self.ref.child("Foods/\(self.itemCount)/iconImage").setValue(food.iconImage)
//      self.ref.child("Foods/\(self.itemCount)/info").setValue(food.info)
//      self.ref.child("Foods/\(self.itemCount)/level").setValue(food.level)
//      self.ref.child("Foods/\(self.itemCount)/meterialImage").setValue(food.meterialImages)
//      self.ref.child("Foods/\(self.itemCount)/recipe").setValue(food.recipe)
//      self.ref.child("Foods/\(self.itemCount)/sensitivity").setValue(food.sensitivity)
      
//      metadata.setValue(food.title, forKeyPath: "\(self.itemCount)/title")
//      metadata.setValue(food.comment, forKeyPath: "\(self.itemCount)/Comment")
//      metadata.setValue(food.foodMeterial, forKeyPath: "\(self.itemCount)/foodMeterial")
//      metadata.setValue(food.iconImage, forKeyPath: "\(self.itemCount)/iconImage")
//      metadata.setValue(food.info, forKeyPath: "\(self.itemCount)/info")
//      metadata.setValue(food.level, forKeyPath: "\(self.itemCount)/level")
//      metadata.setValue(food.meterialImages, forKeyPath: "\(self.itemCount)/meterialImage")
//      metadata.setValue(food.recipe, forKeyPath: "\(self.itemCount)/recipe")
//      metadata.setValue(food.sensitivity, forKeyPath: "\(self.itemCount)/sensitivity")
      
      if let image = CollVC.food.images[food.iconImage] as? UIImage {
        self.uploadImage(image: image, name: food.iconImage)
      }
      if let image = CollVC.food.images[food.iconImage] as? UIImage {
        self.uploadImage(image: image, name: food.foodMeterial[0].0)
      }
      if let image = CollVC.food.images[food.iconImage] as? UIImage {
        self.uploadImage(image: image, name: food.foodMeterial[0].1)
      }
      
      NotificationCenter.default.post(name: .reload, object: nil)
      self.itemCounting()
 //   })
  }
  
  func readFoodList() {
    itemCount = 0
    
    ref.child("Foods").observeSingleEvent(of: .value) { (metadata) in
      for num in 0..<metadata.childrenCount {
        let commentArray = metadata.childSnapshot(forPath: "\(num)/Comment").value as? [String]
        let foodMeterial = metadata.childSnapshot(forPath: "\(num)/foodMeterial").value as? [String]
        let iconImage = metadata.childSnapshot(forPath: "\(num)/iconImage").value as? String
        let info = metadata.childSnapshot(forPath: "\(num)/info").value as? String
        let level = metadata.childSnapshot(forPath: "\(num)/level").value as? String
        let meterialImage = metadata.childSnapshot(forPath: "\(num)/meterialImage").value as? [String]
        let recipe = metadata.childSnapshot(forPath: "\(num)/recipe").value as? [String]
        let sensitivity = metadata.childSnapshot(forPath: "\(num)/sensitivity").value as? String
        let title = metadata.childSnapshot(forPath: "\(num)/title").value as? String
        
        let tuple: [(String,String)] = [(foodMeterial?[0] ?? "", foodMeterial?[1] ?? "")]
        
        let food = Food(iconImage: iconImage ?? "",
                        title: title ?? "",
                        level: level ?? "",
                        comment: commentArray ?? [],
                        foodMeterial: tuple,
                        meterialImages: meterialImage ?? [],
                        recipe: recipe ?? [],
                        sensitivity: sensitivity ?? "",
                        info: info ?? "")
        
        CollVC.food.list.append(food)
        self.downloadImage(name: iconImage ?? "")
        self.downloadImage(name: meterialImage?[0] ?? "")
        self.downloadImage(name: meterialImage?[1] ?? "")
        
        //        self.itemCount += 1
        self.itemCounting()
      }
    }
    /*
    databaseHandle = ref?.child("Foods").observeSingleEvent(of: .value , with: { (metadata) in
      for num in 0..<metadata.childrenCount {
        let commentArray = metadata.childSnapshot(forPath: "\(num)/Comment").value as? [String]
        let foodMeterial = metadata.childSnapshot(forPath: "\(num)/foodMeterial").value as? [String]
        let iconImage = metadata.childSnapshot(forPath: "\(num)/iconImage").value as? String
        let info = metadata.childSnapshot(forPath: "\(num)/info").value as? String
        let level = metadata.childSnapshot(forPath: "\(num)/level").value as? String
        let meterialImage = metadata.childSnapshot(forPath: "\(num)/meterialImage").value as? [String]
        let recipe = metadata.childSnapshot(forPath: "\(num)/recipe").value as? [String]
        let sensitivity = metadata.childSnapshot(forPath: "\(num)/sensitivity").value as? String
        let title = metadata.childSnapshot(forPath: "\(num)/title").value as? String
        
        let tuple: [(String,String)] = [(foodMeterial?[0] ?? "", foodMeterial?[1] ?? "")]
        
        let food = Food(iconImage: iconImage ?? "",
                     title: title ?? "",
                     level: level ?? "",
                     comment: commentArray ?? [],
                     foodMeterial: tuple,
                     meterialImages: meterialImage ?? [],
                     recipe: recipe ?? [],
                     sensitivity: sensitivity ?? "",
                     info: info ?? "")
        
        CollVC.food.list.append(food)
        self.downloadImage(name: iconImage ?? "")
        self.downloadImage(name: meterialImage?[0] ?? "")
        self.downloadImage(name: meterialImage?[1] ?? "")
        
//        self.itemCount += 1
        self.itemCounting()
      }
    })*/
  }
  
  func downloadImage(name: String) {
    
    // Create a reference to the file you want to download
    let storageRef = Storage.storage().reference()//.child("ios_images").child(imageName)
    let isRef = storageRef.child("swifood/\(name)")
    
    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    isRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        print("error: ", error.localizedDescription)
      } else {
        CollVC.food.images.updateValue( UIImage(data: data!), forKey: name)
//        print("downloadImage: ", CollVC.food.images)
        NotificationCenter.default.post(name: .reload, object: nil)
      }
    }
  }
  
  func uploadImage(image: UIImage, name: String) {
    
    guard let resingImage = resize(image: image, scale: 0.1) else { return print("resize") }
    guard let data = resingImage.pngData() else { return print("dd")}
    //let imageName = "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000)).jpg"
    
    let riversRef = Storage.storage().reference().child("swifood").child(name)
    
    riversRef.putData(data, metadata: nil) { (metadata, error) in
      guard let metadata = metadata else {
        // Uh-oh, an error occurred!
        print("error")
        return
      }
      
      // You can also access to download URL after upload.
      riversRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          // Uh-oh, an error occurred!
          print("error2")
          return
        }
      }
    }
  }
  
  func resize(image: UIImage, scale: CGFloat) -> UIImage? {
    let transform = CGAffineTransform(scaleX: scale, y: scale)
    let size = image.size.applying(transform)
    UIGraphicsBeginImageContext(size)
    image.draw(in: CGRect(origin: .zero, size: size))
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resultImage
  }
  
  func addFoodList() {
//    databaseHandle = ref?.child("Foods").ob
  }
  
}
