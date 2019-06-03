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
  
  init() {
    ref = Database.database().reference()
  }
  
  func writeFoodList(food: Food) {
    let keyPath = ref.child("Foods").childByAutoId()// else { return print("firebase create key fail")}
    
    keyPath.updateChildValues(["title": food.title])
    keyPath.updateChildValues(["Comment": food.comment])
    
    let meta = food.getFoodMeterial()
    keyPath.updateChildValues(["foodMeterial": meta])
    
    keyPath.updateChildValues(["iconImage": food.iconImage])
    keyPath.updateChildValues(["info": food.info])
    keyPath.updateChildValues(["level": food.level])
    keyPath.updateChildValues(["meterialImage": food.meterialImages])
    keyPath.updateChildValues(["recipe": food.recipe])
    keyPath.updateChildValues(["sensitivity": food.sensitivity])

    // TODO : write Image Data
    if let image = CollVC.food.images[food.iconImage] as? UIImage {
      self.uploadImage(image: image, name: food.iconImage)
    }
    if let image = CollVC.food.images[food.meterialImages[0]] as? UIImage {
      self.uploadImage(image: image, name: food.meterialImages[0])
    }
    if let image = CollVC.food.images[food.meterialImages[1]] as? UIImage {
      self.uploadImage(image: image, name: food.meterialImages[1])
    }
    
    NotificationCenter.default.post(name: .reload, object: nil)
  }
  
  func readFoodList() {
    
    ref.child("Foods").observe(.childAdded) { (metadata) in
      
      guard let value = metadata.value  as? [String:Any] else { return print("metadata.value: nil")}
      
      let commentArray = value["Comment"] as? [String]
      let foodMeterial = value["foodMeterial"] as? [String]
      let iconImage = value["iconImage"] as? String
      let info = value["info"] as? String
      let level = value["level"] as? String
      let sensitivity = value["sensitivity"] as? String
      let meterialImage = value["meterialImage"] as? [String]
      let recipe = value["recipe"] as? [String]
      let title = value["title"] as? String
      
      var tuple: [(String, String)] = []
      
      for num in 0..<(foodMeterial?.count ?? 0) {
        guard num % 2 == 0 else { continue }
        let tupleAppen = (foodMeterial?[num] ?? "", foodMeterial?[num + 1] ?? "")
        tuple.append(tupleAppen)
      }
      
      let food = Food(iconImage: iconImage ?? "",
                      title: title ?? "",
                      level: level ?? "",
                      comment: commentArray ?? [],
                      foodMeterial: tuple,
                      meterialImages: meterialImage ?? [],
                      recipe: recipe ?? [],
                      sensitivity: sensitivity ?? "",
                      info: info ?? "")
      
      print("download image: ", meterialImage)
      
      CollVC.food.list.append(food)
      self.downloadImage(name: iconImage ?? "")
      self.downloadImage(name: meterialImage?[0] ?? "")
      self.downloadImage(name: meterialImage?[1] ?? "")
    }
  }
  
  func downloadImage(name: String) {
    // Create a reference to the file you want to download
    let storageRef = Storage.storage().reference()//.child("ios_images").child(imageName)
    let isRef = storageRef.child("swifood/\(name)")
    
    // Download in memory with a maximum allowed size of 10MB (10 * 1024 * 1024 bytes)
    isRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
      if let error = error {
        print("\n/////////////// downloadImage error: ", error.localizedDescription)
      } else {
        CollVC.food.images.updateValue( UIImage(data: data!), forKey: name)
        NotificationCenter.default.post(name: .reload, object: nil)
      }
    }
  }
  
  func uploadImage(image: UIImage, name: String) {
//    guard let resingImage = resize(image: image, scale: 0.3) else { return print("resize") }
    guard let resingData = image.jpegData(compressionQuality: 0.3) else { return print("resize") }
//    guard let resingImage = UIImage(data: resingData) else { return }
    //let imageName = "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000)).jpg"
    
    let riversRef = Storage.storage().reference().child("swifood").child(name)
    
    let uploadTesk = riversRef.putData(resingData, metadata: nil) { (metadata, error) in
      guard let metadata = metadata else {
        // Uh-oh, an error occurred!
        print("-----metadata-----uploadImage error")
        return
      }
      
      // You can also access to download URL after upload.
      riversRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          // Uh-oh, an error occurred!
          print("-----downloadURL-----uploadImage error2")
          return
        }
      }
    }
    
    print("\n ================= progress ====================== \n")
    uploadTesk.observe(.progress) { snapshot in
      print("\(name) progress : \(snapshot.progress)")
      
      
    }
  }
}
