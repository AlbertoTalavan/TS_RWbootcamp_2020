//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 14/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import UIKit

protocol Roundable: UIView {
  var cornerRadius: CGFloat {get set}
  func round()
  
}
