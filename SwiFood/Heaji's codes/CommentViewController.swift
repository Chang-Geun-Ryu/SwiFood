//
//  CommentViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
  var foodData: FoodData?
  var food : Food?
  
  var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  var inputTextView = InputCommentView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Comment"
    view.backgroundColor = .white
    
    tableView.dataSource = self
    view.addSubview(tableView)
    view.addSubview(inputTextView)
    
    tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
    
    NotificationCenter.default.addObserver(self, selector: #selector(addComment), name: NSNotification.Name("CommentTap"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(addComment), name: NSNotification.Name("addCommentDidTap"), object: nil)
    keyboardSetting()
    autolayout()
    
    print("setup complete")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
  }
  
  @objc func barButtonAction(_ sender: UIBarButtonItem) {
    
  }
  
  @objc private func addComment(){
    
    self.food?.comment.append(inputTextView.textField.text!)
    self.tableView.reloadData()
  }
  func keyboardSetting(){
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.inputTextView.textField.resignFirstResponder()
  }
  
  @objc private func keyboardWillHide(_ sender: Notification){
    self.view.frame.origin.y = 0
  }
  
  @objc private func keyboardWillShow(_ sender: Notification){
    self.view.frame.origin.y = -100
  }
  
  
  func autolayout(){
    let guide = view.safeAreaLayoutGuide
    inputTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: guide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
      
      inputTextView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
      inputTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      inputTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      inputTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      inputTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
      ])
    
  }
}

extension CommentViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return food?.comment.count ?? 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
    let ran = String(Int.random(in: 1...4))
    cell.feedImageView.image = UIImage(named: "user\(ran)")
    cell.commentLabel.text = food?.comment[indexPath.row]
    cell.feedNickNameLabel.text = food?.comment[indexPath.row]
    return cell
  }
  
  
}
