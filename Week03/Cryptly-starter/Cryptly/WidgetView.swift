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

/*
class WidgetView: UIView, Roundable {
  internal var cornerRadius: CGFloat = 0.0
  

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func round() {
    layer.cornerRadius = cornerRadius
  }
  
  func setCornerRadius(to radius: CGFloat) {
    cornerRadius = radius
  }

  
  
}
 */

