//
//  SignInViewController.swift
//  CapstoneRW20
//
//  Created by Alberto Talaván on 11/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
  //outlets
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var usernameTF: UITextField!
  
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var emailTF: UITextField!
  
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var passwordTF: UITextField!
  
  @IBOutlet weak var signUpButton: UIButton!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  //MARK: - Button Action
  
  @IBAction func signIn(_ sender: UIButton) {
    //code to add user to Firebase
    
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
