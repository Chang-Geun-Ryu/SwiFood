//
//  FirebaseTestVC.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
import Firebase

class FirebaseTestVC: UIViewController {
  
  let testButton = UIButton(type: .system)
  let imageButton = UIButton(type: .system)
  let picker = UIImagePickerController()
  
  let imageView = UIImageView()
  
  let iconImageButton = UIButton(type: .system)
  let metaImageButtonFirst = UIButton(type: .system)
  let metaImageButtonSecond = UIButton(type: .system)
  
  var iconImage = UIImage(named: "")
  var metaImageFirst = UIImage(named: "")
  var metaImageSecond = UIImage(named: "")
  
  let iconimageView = UIImageView(image: UIImage(named: "img"))
  let metaFirstImageView = UIImageView(image: UIImage(named: "img"))
  let metaSecondImageView = UIImageView(image: UIImage(named: "img"))
  
  var iconImageName = ""
  var metaFirstName = ""
  var metaSecondName = ""
  
  var selectButton = 0
  
  let titleTextField = UITextField()
  let levelLabel = UILabel()
  
  let foodMeterialLeftOneTF   = UITextField()
  let foodMeterialRightOneTF  = UITextField()
  let foodMeterialLeftTwoTF   = UITextField()
  let foodMeterialRightTwoTF  = UITextField()
  let foodMeterialLeftThreeTF = UITextField()
  let foodMeterialRightThreeTF = UITextField()
  
  let recipeStepOneTF   = UITextField()
  let recipeStepTwoTF   = UITextField()
  let recipeStepThreeTF = UITextField()
  let recipeStepFourTF  = UITextField()
  let recipeStepFiveTF  = UITextField()
  
  let uploadButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButtons()
    
    setupView()
    picker.delegate = self
    picker.allowsEditing = true
  }
  
  func setupView() {
    let pading = 10
    let posX = 15
    var posY = Int(view.frame.width/3 + 100)
    let width = Int(view.frame.width)
    
    titleTextField.frame = CGRect(x: posX, y: posY, width: Int(width - pading * 2), height: 40)
    titleTextField.placeholder = "요리이름을 입력하세요"
    titleTextField.borderStyle = .roundedRect
    titleTextField.delegate = self
    view.addSubview(titleTextField)
    
    posY += 45
    levelLabel.frame = CGRect(x: posX, y: posY, width: Int(width - pading * 2), height: 40)
    levelLabel.text = "Level: ★★★☆☆"
    levelLabel.textColor = .lightGray
    levelLabel.font =  UIFont(name: "Palatino", size: 15)
    view.addSubview(levelLabel)
    
    posY += 45
    foodMeterialLeftOneTF.frame = CGRect(x: posX, y: posY, width: Int(width/2 - pading*2), height: 40)
    foodMeterialLeftOneTF.placeholder = "재료 1"
    foodMeterialLeftOneTF.borderStyle = .roundedRect
    foodMeterialLeftOneTF.delegate = self
    foodMeterialLeftOneTF.font = UIFont(name: "Palatino", size: 15)
    view.addSubview(foodMeterialLeftOneTF)
    
    foodMeterialRightOneTF.frame = CGRect(x: posX + width/2, y: posY, width: Int(width/2 - pading*2), height: 40)
    foodMeterialRightOneTF.placeholder = "재료 1 수량"
    foodMeterialRightOneTF.borderStyle = .roundedRect
    foodMeterialRightOneTF.font = UIFont(name: "Palatino", size: 15)
    foodMeterialRightOneTF.delegate = self
    view.addSubview(foodMeterialRightOneTF)
    
    posY += 45
    foodMeterialLeftTwoTF.frame = CGRect(x: posX, y: posY, width: Int(width/2 - pading*2), height: 40)
    foodMeterialLeftTwoTF.placeholder = "재료 2"
    foodMeterialLeftTwoTF.borderStyle = .roundedRect
    foodMeterialLeftTwoTF.font = UIFont(name: "Palatino", size: 15)
    foodMeterialLeftTwoTF.delegate = self
    view.addSubview(foodMeterialLeftTwoTF)
    
    foodMeterialRightTwoTF.frame = CGRect(x: posX + width/2, y: posY, width: Int(width/2 - pading*2), height: 40)
    foodMeterialRightTwoTF.placeholder = "재료 2 수량"
    foodMeterialRightTwoTF.borderStyle = .roundedRect
    foodMeterialRightTwoTF.font = UIFont(name: "Palatino", size: 15)
    foodMeterialRightTwoTF.delegate = self
    view.addSubview(foodMeterialRightTwoTF)
    
    posY += 45
    foodMeterialLeftThreeTF.frame = CGRect(x: posX, y: posY, width: Int(width/2 - pading*2), height: 40)
    foodMeterialLeftThreeTF.placeholder = "재료 3"
    foodMeterialLeftThreeTF.borderStyle = .roundedRect
    foodMeterialLeftThreeTF.font = UIFont(name: "Palatino", size: 15)
    foodMeterialLeftThreeTF.delegate = self
    view.addSubview(foodMeterialLeftThreeTF)
    
    foodMeterialRightThreeTF.frame = CGRect(x: posX + width/2, y: posY, width: Int(width/2 - pading*2), height: 40)
    foodMeterialRightThreeTF.placeholder = "재료 3 수량"
    foodMeterialRightThreeTF.borderStyle = .roundedRect
    foodMeterialRightThreeTF.font = UIFont(name: "Palatino", size: 15)
    foodMeterialRightThreeTF.delegate = self
    view.addSubview(foodMeterialRightThreeTF)
    
    posY += 45
    recipeStepOneTF.frame = CGRect(x: posX, y: posY, width: Int(width - pading*2), height: 40)
    recipeStepOneTF.placeholder = "Step1 Recipe"
    recipeStepOneTF.borderStyle = .roundedRect
    recipeStepOneTF.font = UIFont(name: "Palatino", size: 15)
    recipeStepOneTF.delegate = self
    view.addSubview(recipeStepOneTF)
    
    posY += 45
    recipeStepTwoTF.frame = CGRect(x: posX, y: posY, width: Int(width - pading*2), height: 40)
    recipeStepTwoTF.placeholder = "Step2 Recipe"
    recipeStepTwoTF.borderStyle = .roundedRect
    recipeStepTwoTF.font = UIFont(name: "Palatino", size: 15)
    recipeStepTwoTF.delegate = self
    view.addSubview(recipeStepTwoTF)
    
    posY += 45
    recipeStepThreeTF.frame = CGRect(x: posX, y: posY, width: Int(width - pading*2), height: 40)
    recipeStepThreeTF.placeholder = "Step3 Recipe"
    recipeStepThreeTF.borderStyle = .roundedRect
    recipeStepThreeTF.font = UIFont(name: "Palatino", size: 15)
    recipeStepThreeTF.delegate = self
    view.addSubview(recipeStepThreeTF)
    
    posY += 45
    recipeStepFourTF.frame = CGRect(x: posX, y: posY, width: Int(width - pading*2), height: 40)
    recipeStepFourTF.placeholder = "Step4 Recipe"
    recipeStepFourTF.borderStyle = .roundedRect
    recipeStepFourTF.font = UIFont(name: "Palatino", size: 15)
    recipeStepFourTF.delegate = self
    view.addSubview(recipeStepFourTF)
    
    posY += 45
    recipeStepFiveTF.frame = CGRect(x: posX, y: posY, width: Int(width - pading*2), height: 40)
    recipeStepFiveTF.placeholder = "Step5 Recipe"
    recipeStepFiveTF.borderStyle = .roundedRect
    recipeStepFiveTF.font = UIFont(name: "Palatino", size: 15)
    recipeStepFiveTF.delegate = self
    view.addSubview(recipeStepFiveTF)
    
    posY += 45
    uploadButton.frame = CGRect(x: posX, y: posY, width: Int(width - pading*2), height: 50)
    uploadButton.setTitle("Upload", for: .normal)
//    uploadButton.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.8)
    uploadButton.backgroundColor = .white
    uploadButton.layer.cornerRadius = 10
    uploadButton.setTitleColor(.lightGray, for: .normal)
    uploadButton.titleLabel?.font =  UIFont(name: "Palatino", size: 17)
    uploadButton.layer.borderWidth = 0.5
    uploadButton.tintColor = .lightGray
    uploadButton.layer.borderColor = UIColor.gray.cgColor
    
    uploadButton.addTarget(self, action: #selector(uploadData(_:)), for: .touchUpInside)
    view.addSubview(uploadButton)
    
  }
  
  func setupButtons() {
    iconImageButton.setTitle("Main Image", for: .normal)
    iconImageButton.addTarget(self, action: #selector(getImage(_:)), for: .touchUpInside)
    iconImageButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    iconImageButton.setTitleColor(.lightGray, for: .normal)
    iconImageButton.titleLabel?.font =  UIFont(name: "Palatino", size: 15)
    iconImageButton.layer.borderWidth = 2
    view.addSubview(iconImageButton)
    
    metaImageButtonFirst.setTitle("Cooking Image", for: .normal)
    metaImageButtonFirst.addTarget(self, action: #selector(getImage(_:)), for: .touchUpInside)
    metaImageButtonFirst.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    metaImageButtonFirst.setTitleColor(.lightGray, for: .normal)
    metaImageButtonFirst.titleLabel?.font =  UIFont(name: "Palatino", size: 15)
    metaImageButtonFirst.layer.borderWidth = 2
    view.addSubview(metaImageButtonFirst)
    
    metaImageButtonSecond.setTitle("Cooking Image", for: .normal)
    metaImageButtonSecond.addTarget(self, action: #selector(getImage(_:)), for: .touchUpInside)
    metaImageButtonSecond.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    metaImageButtonSecond.setTitleColor(.lightGray, for: .normal)
    metaImageButtonSecond.titleLabel?.font =  UIFont(name: "Palatino", size: 15)
    metaImageButtonSecond.layer.borderWidth = 2
    view.addSubview(metaImageButtonSecond)
    
    iconimageView.backgroundColor = .black
    view.addSubview(iconimageView)
    metaFirstImageView.backgroundColor = .black
    view.addSubview(metaFirstImageView)
    metaSecondImageView.backgroundColor = .black
    view.addSubview(metaSecondImageView)
    
    iconimageView.translatesAutoresizingMaskIntoConstraints = false
    iconimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    iconimageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    iconimageView.trailingAnchor.constraint(equalTo: metaImageButtonFirst.leadingAnchor).isActive = true
    iconimageView.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    iconimageView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    
    metaFirstImageView.translatesAutoresizingMaskIntoConstraints = false
    metaFirstImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    metaFirstImageView.leadingAnchor.constraint(equalTo: iconimageView.trailingAnchor).isActive = true
    metaFirstImageView.trailingAnchor.constraint(equalTo: metaImageButtonSecond.leadingAnchor).isActive = true
    metaFirstImageView.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    metaFirstImageView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    
    metaSecondImageView.translatesAutoresizingMaskIntoConstraints = false
    metaSecondImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    metaSecondImageView.leadingAnchor.constraint(equalTo: metaImageButtonFirst.trailingAnchor).isActive = true
    metaSecondImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    metaSecondImageView.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    metaSecondImageView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    
    iconImageButton.translatesAutoresizingMaskIntoConstraints = false
    iconImageButton.topAnchor.constraint(equalTo: iconimageView.bottomAnchor).isActive = true
    iconImageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    iconImageButton.trailingAnchor.constraint(equalTo: metaImageButtonFirst.leadingAnchor).isActive = true
    iconImageButton.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    iconImageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    metaImageButtonFirst.translatesAutoresizingMaskIntoConstraints = false
    metaImageButtonFirst.topAnchor.constraint(equalTo: metaFirstImageView.bottomAnchor).isActive = true
    metaImageButtonFirst.leadingAnchor.constraint(equalTo: iconImageButton.trailingAnchor).isActive = true
    metaImageButtonFirst.trailingAnchor.constraint(equalTo: metaImageButtonSecond.leadingAnchor).isActive = true
    metaImageButtonFirst.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    metaImageButtonFirst.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    metaImageButtonSecond.translatesAutoresizingMaskIntoConstraints = false
    metaImageButtonSecond.topAnchor.constraint(equalTo: metaSecondImageView.bottomAnchor).isActive = true
    metaImageButtonSecond.leadingAnchor.constraint(equalTo: metaImageButtonFirst.trailingAnchor).isActive = true
    metaImageButtonSecond.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    metaImageButtonSecond.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
    metaImageButtonSecond.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  
  @objc func uploadData(_ sender: UIButton) {
    
    let foodmeta:[(String,String)] = [(foodMeterialLeftOneTF.text ?? "",foodMeterialRightOneTF.text ?? ""),
                    (foodMeterialLeftTwoTF.text ?? "", foodMeterialRightTwoTF.text ?? ""),
                    (foodMeterialLeftThreeTF.text ?? "", foodMeterialRightThreeTF.text ?? "")]
    var recipe = [String]()
    recipe.append(recipeStepOneTF.text ?? "")
    recipe.append(recipeStepTwoTF.text ?? "")
    recipe.append(recipeStepThreeTF.text ?? "")
    recipe.append(recipeStepFourTF.text ?? "")
    recipe.append(recipeStepFiveTF.text ?? "")
    
    let food = Food(iconImage: iconImageName, title: titleTextField.text ?? "title", level: "★★★☆☆", comment: [""], foodMeterial: foodmeta, meterialImages: [metaFirstName, metaSecondName], recipe: recipe, sensitivity: "아주 맛있엉~", info: "존맛")
    
    guard food.checkFoodData() else {return print("food recipe is unstable")}
    
    CollVC.food.list.append(food)
    CollVC.food.images.updateValue(iconImage, forKey: iconImageName)
    CollVC.food.images.updateValue(metaImageFirst, forKey: metaFirstName)
    CollVC.food.images.updateValue(metaImageSecond, forKey: metaSecondName)
    
    FireBaseOperating.Share.writeFoodList(food: food)
    
    // TODO: firebase upload
    NotificationCenter.default.post(name: .reload, object: nil)
  }
  
  func showAlert(success: Bool) {
    let alertController = UIAlertController(title: success ? "저장" : "저장 실패", message: success ? "food recipe가 저장 되었습니다" : "food recipe의 정보가 누락 되었습니다.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: success ? .default : .cancel) { [weak self] (_) in
      guard let `self` = self else { return print("self 가 없어!!!")}
      if success {
        self.uploadLoadingAnimation()
        self.dataClear()
      } else {
        // TODO : upalod fail todo
        
      }
    }
    
    alertController.addAction(okAction)
    
    present(alertController, animated: true)
  }
  
  func uploadLoadingAnimation() {
    
  }
  
  func dataClear() {
    
  }
  
  @objc func getImage(_ sender: UIButton) {
    let alert = UIAlertController(title: "Photo", message: "결정 해줘", preferredStyle: .alert)
    let camera = UIAlertAction(title: "카메라로 찍기", style: .default) { (action) in
      self.picker.sourceType = .camera
      self.present(self.picker, animated: true)
    }
    let album = UIAlertAction(title: "앨법에서 가져오기", style: .default) { (action) in
      self.picker.sourceType = .photoLibrary
      self.present(self.picker, animated: true)
    }
    let cancel = UIAlertAction(title: "취소", style: .cancel)
    
    alert.addAction(camera)
    alert.addAction(album)
    alert.addAction(cancel)
    
    if sender == iconImageButton {selectButton = 0}
    else if sender == metaImageButtonFirst {selectButton = 1}
    else if sender == metaImageButtonSecond {selectButton = 2}
    
    present(alert, animated: true)
  }
  
  func nouse() {
    imageView.backgroundColor = .black
    view.addSubview(imageView)
    
    testButton.setTitle("imageUpload", for: .normal)
    testButton.addTarget(self, action: #selector(photoUpload(_:)), for: .touchUpInside)
    view.addSubview(testButton)
    
    imageButton.setTitle("imagedownlod", for: .normal)
    imageButton.addTarget(self, action: #selector(photoDownload(_:)), for: .touchUpInside)
    view.addSubview(imageButton)
    
    testButton.translatesAutoresizingMaskIntoConstraints = false
    testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
    testButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    testButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    imageButton.translatesAutoresizingMaskIntoConstraints = false
    imageButton.topAnchor.constraint(equalTo: testButton.bottomAnchor, constant: 10).isActive = true
    imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    imageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    imageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.bottomAnchor.constraint(equalTo: testButton.topAnchor).isActive = true
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    
  }
  
  @objc func photoDownload(_ sender: UIButton) {
    // Create a reference to the file you want to download
    let storageRef = Storage.storage().reference()//.child("ios_images").child(imageName)
    let islandRef = storageRef.child("ios_images/580222007662.jpg")
    
    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    islandRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
      } else {
        // Data for "images/island.jpg" is returned
        self.imageView.image = UIImage(data: data!)
      }
    }
  }
  
  @objc func photoUpload(_ sender: UIButton) {
    let alert = UIAlertController(title: "Photo", message: "결정 해줘", preferredStyle: .alert)
    let camera = UIAlertAction(title: "카메라로 찍기", style: .default) { (action) in
      self.picker.sourceType = .camera
      self.present(self.picker, animated: true)
    }
    let album = UIAlertAction(title: "앨법에서 가져오기", style: .default) { (action) in
      self.picker.sourceType = .photoLibrary
      self.present(self.picker, animated: true)
    }
    
    alert.addAction(camera)
    alert.addAction(album)
    
    present(alert, animated: true)
  }
  
  
  func firebaseUpload(image: UIImage, name: String) {
    guard let data = image.pngData() else { return print("pngdata")}
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
}

extension FirebaseTestVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else { return }
    guard let resingData = image.jpegData(compressionQuality: 0.3) else { return print("resize") }
    guard let resingImage = UIImage(data: resingData) else { return }
    let imageName = "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000))"
    
    switch selectButton {
    case 0:
      print(imageName)
      iconImageName = imageName
      iconImage = resingImage
      iconimageView.image = resingImage
    case 1:
      print(imageName)
      metaFirstName = imageName
      metaImageFirst = resingImage
      metaFirstImageView.image = resingImage
    default:
      print(imageName)
      metaSecondName = imageName
      metaImageSecond = resingImage
      metaSecondImageView.image = resingImage
    }
    
    dismiss(animated: true, completion: nil)
  }
}

extension FirebaseTestVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
