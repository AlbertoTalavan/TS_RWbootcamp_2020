//
//  RGB.swift
//  BullsEye
//


import UIKit

extension UIColor {
  convenience init(rgbStruct rgb: RGB) {
    let r = CGFloat(rgb.r) / 255.0
    let g = CGFloat(rgb.g) / 255.0
    let b = CGFloat(rgb.b) / 255.0
    self.init(red: r, green: g, blue: b, alpha:1.0)
  }
}

struct RGB {
  var r = 127
  var g = 127
  var b = 127
   
   mutating func setRandomValues(){
      r = Int.random(in: 1...255)
      g = Int.random(in: 1...255)
      b = Int.random(in: 1...255)
   }
   
   mutating func setDefaultValues() {
      r = 127
      g = 127
      b = 127
   }
  
  func difference(target: RGB) -> Double {
    let rDiff = Double(r - target.r)
    let gDiff = Double(g - target.g)
    let bDiff = Double(b - target.b)
    return sqrt((rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)/3.0) / 255.0
  }

}
