//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   @IBOutlet weak var tableview: UITableView!
   

   

   
   override func viewDidLoad() {
      super.viewDidLoad()
   
      MediaPostsHandler.shared.getPosts() 

      setUpTableView()

   }
   
   override func viewDidAppear(_ animated: Bool) {
      tableview.reloadData()
   }
   
   
   func setUpTableView() {
      // Set delegates, register custom cells, set up datasource, etc.
      tableview.dataSource = self
      tableview.delegate = self

   }
   
   func configureCell(for cell: CustomCell, at indexPath: IndexPath, with image: UIImage?) {
      //Easter Egg
      if MediaPostsHandler.shared.mediaPosts[indexPath.row].userName == "Homer Simpson" {
         cell.badgeImage.image = UIImage(named: "Homer")
         cell.badgeImage.layer.cornerRadius = cell.badgeImage.frame.size.width / 2
      } else {
         cell.badgeImage.image = UIImage(named: "mascot_swift-badge")
      }
      
      
      //Common to any cell
      cell.userNameLabel.text = MediaPostsHandler.shared.mediaPosts[indexPath.row].userName
      cell.timeStampLabel.text = MediaPostsHandler.shared.mediaPosts[indexPath.row].timestamp.toString()
      cell.textBodyLabel.text = MediaPostsHandler.shared.mediaPosts[indexPath.row].textBody
      
      if image != nil {
         cell.multimedia.image = image
         cell.multimedia.isHidden = false
  
      } else {
         cell.multimedia.isHidden = true

      }

   }
   

   
   //MARK: - IBActions
   @IBAction func didPressCreateTextPostButton(_ sender: Any) {
      addTextPost()
   }
   
//   @IBAction func didPressCreateImagePostButton(_ sender: Any) {
//      // not used, used a segue to AddImagePost instead
//   }
   
   
   //MARK: - Add post
   func addTextPost() {
      let alert = UIAlertController(title: "Type", message: "Write your post into the box", preferredStyle: .alert)
      let textToPost = UITextField()
      let userName = UITextField()
      var post: TextPost?
      
      let okAction = UIAlertAction(title: "Send", style: .default){ action in
         textToPost.text = alert.textFields?[1].text
         userName.text = alert.textFields?[0].text
         
         //Easter egg
         if userName.text == "" && textToPost.text?.count == 0 {
            userName.text = "Homer Simpson"
            textToPost.text = "Ouch!"
         }else if userName.text == "" {
            userName.text = "Me"
         }
         
         post = TextPost(textBody: textToPost.text, userName: userName.text ?? "Hommer Simpson", timestamp: Date() )
         MediaPostsHandler.shared.addTextPost(textPost: post!)
         self.tableview.reloadData()
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
      
      alert.addAction(okAction)
      alert.addAction(cancelAction)
      
      alert.addTextField { (textfield) in
         textfield.placeholder = "Name..."
         
      }
      
      alert.addTextField { textfield in
         textfield.placeholder = "your message here..."
         
      }
       
      
      present(alert, animated: true)
   }

}


//MARK: - Extensions
extension ViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return MediaPostsHandler.shared.mediaPosts.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomCell
      
      if let imagePost = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? ImagePost {
         let image = imagePost.image
         configureCell(for: cell, at: indexPath, with: image)
      }else {
         configureCell(for: cell, at: indexPath, with: nil)
      }
      
      return cell
   }
   
}

extension ViewController: UITableViewDelegate {

}

extension Date {
    func toString(withFormat format: String = "d MMM, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}




