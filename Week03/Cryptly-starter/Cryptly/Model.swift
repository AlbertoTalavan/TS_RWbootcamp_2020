//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 13/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//


import Foundation

struct CryptoCurrency: Codable {
  enum Trend: Int, Codable {
    case falling, rising
  }
  
  var name: String
  var symbol: String
  var currentValue: Double
  var previousValue: Double
  
  var difference: Double {
    currentValue - previousValue
  }
  
  var trend: Trend {
    difference < 0 ? .falling : .rising
  }
  
}
