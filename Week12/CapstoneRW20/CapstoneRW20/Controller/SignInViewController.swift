//
//  SignInViewController.swift
//  CapstoneRW20
//
//  Created by Alberto Talaván on 11/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignInViewController: UIViewController {
  //outlets
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var usernameTF: UITextField!
  
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var emailTF: UITextField!
  
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var passwordTF: UITextField!
  
  @IBOutlet weak var signUpButton: UIButton!
  
  let db = Firestore.firestore()
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  //MARK: - Button Action
  @IBAction func signIn(_ sender: UIButton) {

    //validate the fields
    let error = validateFields()
    
    if error != nil {
      //show error alert view
      errorAlertView(message: error ?? "something went wrong")
    } else {
      //create the user (mail-pass) on the auth db
      Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (result, error) in
        //check for error
        if error != nil {
          //there was an error creating the user
          print(error?.localizedDescription)
          self.errorAlertView(message: "Error creating user")
        } else {
          //we can create the document into "users" with the info of the new user auth
          self.db.collection("users").document((result?.user.uid)!).setData(["name": self.usernameTF.text]) { (err) in

          
//          self.db.collection("users").addDocument(data: ["name": self.usernameTF.text, "uuid": result?.user.uid]) { (err) in
            if err != nil {
              print(err?.localizedDescription)
              self.errorAlertView(message: "something went wrong")
            } else {
             print("User created successfully")
              
              
              
            }
          }
          //transition to the home screen
          let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
          
          homeViewController?.username = self.usernameTF.text
          
          self.view.window?.rootViewController = homeViewController
          self.view.window?.makeKeyAndVisible()
        }
      }

    }
    
    
  }
  
  
  
  
  //MARK: - Fields validation Methods
  func validateFields() -> String? {
    //Check all fields are filled in
//    if usernameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//      emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//      passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//      return "Please fill in all the fields"
//    }
//
//    //check email
//    if isValidEmail(emailTF.text ?? "") == false {
//      return "Please make sure your email format is right"
//    }
//
//    //check password
//    if isValidPassword(passwordTF.text ?? "") == false {
//      return "Please make sure your password follows all the password rules"
//    }
    
    return nil
  }
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
