//
//  CommentViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    // HJ
    var foodData: FoodData?
    
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
        
        navigationItem.backBarButtonItem?.title = "<"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
 
    @objc func barButtonAction(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func addComment(){
        //self.foodData!.comments.append(inputTextView.textField.text!)
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
        self.view.frame.origin.y = -150
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

      return foodData?.comments?.count ?? 0
//      foodData?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        print(foodData?.comments, "row", indexPath.row)
        
        cell.commentLabel.text = foodData?.comments?[indexPath.row] ?? ""
        return cell
    }
    
    
}
