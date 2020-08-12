//
//  ViewController.swift
//  CapstoneRW20
//
//  Created by Alberto Talaván on 11/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  //outlets
  @IBOutlet weak var imageLogo: UIImageView!
  
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var userTF: UITextField!
  
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var passwordTF: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  
  
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  //MARK: - Login Button Action
  @IBAction func logInto(_ sender: UIButton) {
    //code to connect to Firebase Auth...
    
  }
  


}

