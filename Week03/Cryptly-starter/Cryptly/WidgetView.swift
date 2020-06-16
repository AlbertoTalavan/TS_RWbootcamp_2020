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
  
  func setView() {
    //no changing components
       layer.borderWidth   = 1.0
       layer.shadowColor   = UIColor.black.withAlphaComponent(0.2).cgColor
       layer.shadowOffset  = CGSize(width: 0, height: 2)
       layer.shadowRadius  = 4
       layer.shadowOpacity = 0.8
  }
  
}


