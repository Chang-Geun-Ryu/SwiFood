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
import FirebaseAuth

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
      self.getRecipeData(snapshot: metadata)
    }
  }
  
  func reloadData() {
    // login or logout시 호출 필요
    CollVC.food.list.removeAll()
    CollVC.food.defaultFoodRecipe()
    ref.child("Foods").observeSingleEvent(of: .value, with: { (metadata) in
      self.getRecipeData(snapshot: metadata)
    })
    
  }
  
  private func getRecipeData(snapshot: DataSnapshot) {
    guard let value = snapshot.value  as? [String:Any] else { return print("snapshot: nil")}
    
    // MARK - user 가 nil 일때 처리
    if let authEmail = Auth.auth().currentUser?.email {   // login이 되어있는 경우
      guard let email = value["user"] as? String,
        authEmail == email   // user 가 nil 이거나, email이 기입이 안되어있거나
        else { return print("food recipe is private (login status)") }
    } else {  // login이 안되어 있을 경우, email 이 비어 있으면 진행(email 기입 되었다면 private recipe info)
      guard let email = value["user"] as? String,
        email.isEmpty else { return print("food recipe is private (logout status)") }
    }
    
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
    
    CollVC.food.list.append(food)
    self.downloadImage(name: iconImage ?? "")
    self.downloadImage(name: meterialImage?[0] ?? "")
    self.downloadImage(name: meterialImage?[1] ?? "")
  }
  
  func downloadImage(name: String) {
    // Create a reference to the file you want to download
    let storageRef = Storage.storage().reference()//.child("ios_images").child(imageName)
    let isRef = storageRef.child("swifood/\(name)")
    
    // Download in memory with a maximum allowed size of 10MB (10 * 1024 * 1024 bytes)
    let downloadTask = isRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
      if let error = error {
        print("\n /////////////// downloadImage error: ", error.localizedDescription)
      } else {
        CollVC.food.images.updateValue( UIImage(data: data!), forKey: name)
        NotificationCenter.default.post(name: .reload, object: nil)
      }
    }
    
    print("\n ================= progress ====================== \n")
    downloadTask.observe(.progress) { snapshot in
//      print("\(name)  fileTotalCount progress : \(snapshot.progress?.completedUnitCount)")
      print("\(name)  Fraction completed : \(snapshot.progress?.fractionCompleted)")
    }
  }
  
  func uploadImage(image: UIImage, name: String) {
    guard let resingData = image.jpegData(compressionQuality: 0.3) else { return print("resize") }
    
    let riversRef = Storage.storage().reference().child("swifood").child(name)
    
    let uploadTesk = riversRef.putData(resingData, metadata: nil) { (metadata, error) in
      guard let metadata = metadata else {
        print("-----metadata-----uploadImage error")
        return
      }
      
      // You can also access to download URL after upload.
      riversRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
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
