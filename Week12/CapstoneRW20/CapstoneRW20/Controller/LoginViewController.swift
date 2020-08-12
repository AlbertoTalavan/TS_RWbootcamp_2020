//
//  ViewController.swift
//  CapstoneRW20
//
//  Created by Alberto Talaván on 11/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore



class LoginViewController: UIViewController {
  //outlets
  @IBOutlet weak var imageLogo: UIImageView!
  
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var emailTF: UITextField!
  
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var passwordTF: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  
  let db = Firestore.firestore()

  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  //MARK: - Login Button Action
  @IBAction func logInto(_ sender: UIButton) {
    //validate text fields
    let error = validateFields()
    
    //cleaning email Text Field
    let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if error != nil {
      //show error alert view
      errorAlertView(message: error ?? "something went wrong")
    } else {
      var name = ""
      //signing in Firebase Auth
      Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (result, error) in
        if error != nil {
          print(error?.localizedDescription)
          self.errorAlertView(message: "wrong email and/or password")
          
        } else {
          
          self.db.collection("users").document((result?.user.uid)!).getDocument { (snapshot, err) in
            name = (snapshot?.get("name")) as! String
            print("El primero name:" + name)
          }
          
          let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
          
          print("El último name:" + name)
          homeViewController?.username = name
          
          self.view.window?.rootViewController = homeViewController
          self.view.window?.makeKeyAndVisible()
        }
        
      }
      
    }
  }
  
  //MARK: - Validate fields
  func validateFields() -> String? {
    //Check all fields are filled in
    if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
      passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      return "Please fill in all the fields"
    }
    
    //check email
    if isValidEmail(emailTF.text ?? "") == false {
      return "Please make sure your email format is right"
    }
    
    //check password
//    if isValidPassword(passwordTF.text ?? "") == false {
//      return "Please make sure your password follows all the password rules"
//    }
    
    return nil
  }
  


}

