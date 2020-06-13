//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 13/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//


import Foundation

struct CryptoCurrency: Codable {
  var name: String
  var symbol: String
  var currentValue: Double
  var previousValue: Double
  
}
