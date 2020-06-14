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
  var fallingColor: UIColor { get }
  var risingColor: UIColor { get }
  

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
  let fallingColor: UIColor = .systemPink
  let risingColor: UIColor = UIColor(named: "myGreen") ?? UIColor.systemGreen
  
  
  init(backgroundColor: UIColor, textColor: UIColor, borderColor: UIColor, widgetBackgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    self.borderColor = borderColor
    self.widgetBackgroundColor = widgetBackgroundColor
    
  }


  init() {
    self.backgroundColor = UIColor(hue: 0.1, saturation: 0.70, brightness: 1.0, alpha: 1.0)
    self.textColor = UIColor.white
    self.borderColor = UIColor(hue: 0.092, saturation: 1.0, brightness: 0.99, alpha: 1.0)
    self.widgetBackgroundColor = UIColor(hue: 0.55, saturation: 0.68, brightness: 0.97, alpha: 1.0)
  }


}

struct DarkTheme: Theme {
  var backgroundColor: UIColor
  var textColor: UIColor
  var borderColor: UIColor
  var widgetBackgroundColor: UIColor
  let fallingColor: UIColor = .systemRed
  let risingColor: UIColor = .systemGreen
  
  init(backgroundColor: UIColor, textColor: UIColor, borderColor: UIColor, widgetBackgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    self.borderColor = borderColor
    self.widgetBackgroundColor = widgetBackgroundColor
  }

  init() {
    self.backgroundColor = UIColor(hue: 0.80, saturation: 0.77, brightness: 0.98, alpha: 1.0)
    self.textColor = UIColor.white
    self.borderColor = UIColor(hue: 0.76, saturation: 0.76, brightness: 1.0, alpha: 1.0)
    self.widgetBackgroundColor = UIColor(hue: 0.727, saturation: 0.55, brightness: 0.76, alpha: 1.0)
  }
  
  
}


