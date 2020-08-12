//
//  HomeViewController.swift
//  CapstoneRW20
//
//  Created by Alberto Talaván on 11/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var wellcomeLabel: UILabel!
  
  var username: String?
  
  

    override func viewDidLoad() {
      super.viewDidLoad()
      
      wellcomeLabel.text? = "Wellcome \(username ?? "")"
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
