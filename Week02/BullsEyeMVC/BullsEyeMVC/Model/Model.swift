//
//  Model.swift
//  BullsEye
//
//  Created by Alberto Talaván on 05/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//


import Foundation

class BullsEyeGame {
   private var currentValue = 0 //doing that we do not need init()
   private var targetValue  = 0
   private var score        = 0
   private var round        = 0
   private var points       = 0
   
   private var difference: Int { //computed property
      abs(currentValue - targetValue)
   }


   //MARK: - SETTERS
   func setCurrentValue(to value: Int){
      currentValue = value
   }

   func setTargetValue(to value: Int){
      targetValue = value
   }
   
   func setScore(to value: Int) {
      score = value
   }
   
   func setRound(to value: Int){
      round = value
   }
   
   func setPoints(to value: Int){
      points = value
   }
   
   
   //MARK: - GETTERS
   func getCurrentValue() -> Int{
      currentValue
   }
   
   func getTargetValue() -> Int{
      targetValue
   }
   
   func getScore() -> Int{
      score
   }
   
   func getRound() -> Int{
      round
   }
   
   func getPoints() -> Int {
      points
   }
   
   func getDifference() -> Int {
      difference
   }
   
}
