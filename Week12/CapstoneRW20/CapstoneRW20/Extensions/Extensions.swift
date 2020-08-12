//
//  Extensions.swift
//  CapstoneRW20
//
//  Created by Alberto Talaván on 12/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

extension UIViewController {
  
  //MARK: Error alert View
  func errorAlertView(message: String) {
    let av = UIAlertController(title: "Something wrong happened", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    av.addAction(action)
    
    present(av,animated: true)
  }
  
  
  //MARK: - Fields validation Methods
  func isValidPassword(_ password: String) -> Bool {
    /* how is a valid password
     1 - Password length is 8.
     2 - One Alphabet in Password.
     3 - One Special Character in Password.
     */
    print("checking password: \(password)")
    
    let pass = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    let result = pass.evaluate(with: password)
    
    print(".... \(result)")
    
    return result
  }
  
  func isValidEmail(_ mail: String) -> Bool {
    print("validate emilId: \(mail)")
    let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    let test = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = test.evaluate(with: mail)
    
    print(".... \(result)")
    
    return result
    
  }

}

