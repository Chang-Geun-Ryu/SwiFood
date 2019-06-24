//
//  DetailCollectionViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

protocol RecipeCollectionViewControllerDelegate {
    func reload()
}

class RecipeCollectionViewController: UICollectionViewController {
    
    // MARK: - properties
    let layout = UICollectionViewFlowLayout()
    var food: Food?     // data?
    var cellCount = 0
    var cellSection = 0
    
    var delegate: RecipeCollectionViewControllerDelegate?
    
    var nextButton: UIButton =  {
        var button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        return button
    }()
    var previousButton: UIButton =  {
        var button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(previousButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonConfigure()
        setupCollectionView()
        self.collectionView.collectionViewLayout = layout
        picker.delegate = self
        
        registerCollectionViewCell()
     
        naviSet()
    }

    // MARK: - Handler
    
    @objc private func nextButtonDidTap() {
//        print("next")
        if cellCount < 3 {
            collectionView.selectItem(at: IndexPath(item: cellCount + 1, section: 0), animated: true, scrollPosition: .right)
            cellCount += 1
        }
    }
    
    @objc private func previousButtonDidTap() {
//        print("previous")
        if cellCount > 0 {
            collectionView.selectItem(at: IndexPath(item: cellCount - 1, section: 0), animated: true, scrollPosition: .right)
            cellCount -= 1
        }
    }
    // buttonConfigure -> Previous/Next
    private func buttonConfigure() {
        let stackView = UIStackView(arrangedSubviews: [previousButton, nextButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    // MARK: - registerCollectionViewCell
    private func registerCollectionViewCell() {
        self.collectionView.register(UINib(nibName: "RecipeImageCell", bundle: nil), forCellWithReuseIdentifier: "RecipeImageCell")
        self.collectionView.register(UINib(nibName: "RecipeTitleCell", bundle: nil), forCellWithReuseIdentifier: "RecipeTitleCell")
        self.collectionView.register(UINib(nibName: "RecipeStepCell", bundle: nil), forCellWithReuseIdentifier: "RecipeStepCell")
        self.collectionView.register(UINib(nibName: "RecipeMeterialsCell", bundle: nil), forCellWithReuseIdentifier: "RecipeMeterialsCell")
        
    }
    // MARK: - setupCollectionView
    private func setupCollectionView() {
        layout.itemSize = CGSize(width: self.view.frame.width , height: self.view.frame.height * 1 - (navigationController?.navigationBar.frame.height)! )
        
        layout.scrollDirection = .horizontal
        self.collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
    }
    
    // MARK: - naviSet
    func naviSet() {
        let barButton = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = barButton
        
        self.navigationController?.navigationBar.tintColor = .darkGray
        self.navigationController?.navigationBar.isTranslucent = false
        
        // navigation.titleView
        navigationController?.navigationBar.isHidden = false
        let titleView = UIImageView(image: UIImage(named: "recipe"))
        titleView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleView
        
    }
    
    // MARK: - photoSet
   private func createSheetAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "사진찍기", style: .default) { [weak self] _ in
            self?.picker.sourceType = .camera
            self?.present(self!.picker, animated: true, completion: nil)
        }
        let libraryAction = UIAlertAction(title: "사진선택", style: .default) { [weak self] _ in
            self?.picker.sourceType = .photoLibrary
            self?.present(self!.picker, animated: true, completion: nil)
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancleAction)
        present(alert, animated: true)
    }
    
    // MARK: - save Alert
    private func saveAlert() {
        let alert = UIAlertController(title: "저장", message: nil, preferredStyle: .alert)
        let check = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        present(alert, animated: true)
        alert.addAction(check)
        alert.addAction(cancel)
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeImageCell", for: indexPath) as! RecipeImageCell
            cell.delegate = self
            return cell
        case 1:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeTitleCell", for: indexPath) as! RecipeTitleCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeMeterialsCell", for: indexPath) as! RecipeMeterialsCell
            return cell
        case 3:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeStepCell", for: indexPath) as! RecipeStepCell
            cell.delegate = self
            self.delegate = cell
            return cell
        default:
            return UICollectionViewCell()
        }
    
    }

}
extension RecipeCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        food?.recipe[0].recipeImage = image
//        print("recipes: ", recipes[0].recipeDiscription)
        let img = info[.originalImage] as? UIImage
        Recipes.shared.recipes[cellSection].recipeImage = info[.originalImage] as? UIImage
         print("imagePicker: ",Recipes.shared.recipes[cellSection].recipeImage)
        picker.dismiss(animated: true)
        delegate?.reload()
    }
}

// MARK: - phothDelegate
extension RecipeCollectionViewController: RecipeImageCellDelegate {
    func imageSelect(didTapButton button: UIButton) {
        
        createSheetAlert(title: "Photo", message: "Select")
    }
}
// MARK: - alertDelegate
extension RecipeCollectionViewController: RecipeStepCellDelegate {
    
    func imageAddGesture(gesture: UITapGestureRecognizer, section: Int?) {
        print("Count of Check", Recipes.shared.recipes.count)
        self.cellSection = section ?? 0
        createSheetAlert(title: "Photo", message: "Select")
        
    }
    
    func alertPresent(saveButton button: UIButton) {
        saveAlert()
    }
    
}
// MARK: - collectionViewFlowLayout -> 전체 collectionView size
extension RecipeCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: self.view.frame.height * 1 - (navigationController?.navigationBar.frame.height)! )
    }
}
