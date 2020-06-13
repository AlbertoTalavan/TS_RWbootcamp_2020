//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 13/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import UIKit

protocol Theme {
  var backgroundColor: UIColor { get }
  var textColor : UIColor { get }
  var borderColor: UIColor { get }
  var widgetBackgroundColor: UIColor { get }
  

}

protocol Themable {
  func registerForTheme()
  func unregisterForTheme()
  func themeChanged()
}



struct LightTheme: Theme {
  var backgroundColor: UIColor
  
  var textColor: UIColor
  
  var borderColor: UIColor
  
  var widgetBackgroundColor: UIColor
  
  init(backgroundColor: UIColor, textColor: UIColor, borderColor: UIColor, widgetBackgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    self.borderColor = borderColor
    self.widgetBackgroundColor = widgetBackgroundColor
    
  }
  
  init() {
    self.backgroundColor = UIColor.systemBackground
    self.textColor = UIColor.label
    self.borderColor = UIColor.systemOrange
    self.widgetBackgroundColor = UIColor.systemGray5
  }

}

struct DarkTheme: Theme {
  var backgroundColor: UIColor
  
  var textColor: UIColor
  
  var borderColor: UIColor
  
  var widgetBackgroundColor: UIColor
  
  init(backgroundColor: UIColor, textColor: UIColor, borderColor: UIColor, widgetBackgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    self.borderColor = borderColor
    self.widgetBackgroundColor = widgetBackgroundColor
    
  }
  
  init() {
    self.backgroundColor = UIColor.systemBackground
    self.textColor = UIColor.label
    self.borderColor = UIColor.systemOrange
    self.widgetBackgroundColor = UIColor.white
  }
  
  
}


//let light = LightTheme()
//let dark = DarkTheme()
