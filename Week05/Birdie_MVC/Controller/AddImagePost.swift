//
//  AddImagePost.swift
//  Birdie_MVC-Final
//
//  Created by Alberto Talaván on 28/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension AddImagePost: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[UIImagePickerController.InfoKey.originalImage] {
         postImage.image = image as? UIImage
         dismiss(animated: true, completion: nil)
      }
   }
}

class AddImagePost: UIViewController {

   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var messageTextField: UITextField!
   @IBOutlet weak var postImage: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      postImage.image = nil
        // Do any additional setup after loading the view.
    }
   
   
   //MARK: - Actions
   
   @IBAction func pickImage(_ sender: Any) {
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.allowsEditing = false
      
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
         picker.sourceType = .photoLibrary
         picker.modalPresentationStyle = .fullScreen
         
      } else {
         return
  
      }
      present(picker, animated: true, completion: nil)
   }
   
   
   @IBAction func send(_ sender: Any) {
      if nameTextField.text == "" { nameTextField.text = "Homer Simpson"}
      if postImage.image == nil {
         if messageTextField.text?.count == 0 { messageTextField.text = "Ouch!" }
         MediaPostsHandler.shared.addTextPost(textPost: TextPost(textBody: messageTextField.text, userName: nameTextField.text!, timestamp: Date()))
      }else {
         MediaPostsHandler.shared.addImagePost(imagePost: ImagePost(textBody: messageTextField.text, userName: nameTextField.text!, timestamp: Date(), image: postImage.image!))
      }
      
      dismiss(animated: true, completion: nil)
   }
   

   @IBAction func cancel(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   

}


