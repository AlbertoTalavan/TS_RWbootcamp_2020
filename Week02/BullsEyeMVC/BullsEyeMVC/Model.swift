//
//  Model.swift
//  BullsEye
//
//  Created by Alberto Talaván on 05/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import Foundation

class BullsEyeGame {
   private var currentValue = 0
   private var targetValue  = 0
   private var score        = 0
   private var round        = 0
   
   private var difference: Int?
   private var points: Int = 0
   
   
   
   
   
   
   //MARK: - SETTERS
   func updateScore(add value: Int) {
      score += value  //updating the score
   }
   
   func addPoints(_ point: Int) {
      points += point
   }
   
   func setCurrentValue(_ value: Int){
      currentValue = value
   }
   
   func setDifference(_ value: Int){
      difference = value
   }
   
   
   //MARK: - GETTERS
   func getCurrentValue() -> Int{
      return currentValue
   }
   
   func getTargetValue() -> Int{
      return targetValue
   }
   
   func getScore() -> Int{
      return score
   }
   
   func getRound() -> Int{
      return round
   }
   
   func getPoints() -> Int {
      return points
   }
   
   func getDifference() -> Int {
      return difference ?? 0
   }
   
   
   //MARK: - Calc. Difference between target and value
   func calculateDifference(this current:Int, minus target: Int){
      difference = current - target
   }
   
   
   
   //MARK: - Game Core Functionality
   //It returns the title of the AlertView and points achieved in this round
   func gameNucleus() -> (String, Int) {
      var title: String
      var points: Int = 0
      
      guard let difference = difference else { return ("something went wront", 0)}
      
      if difference == 0 {
         title = "Perfect!"
         points += 100
      }else if difference == 1 {
         title = "You almost had it!"
         points += 50
      }else if difference < 5 {
         title = "You almost had it!"
      } else if difference < 10 {
         title = "Pretty good!"
      } else {
              title = "meh, not even close!"
      }
      
      
      return (title, points)
   }
   
   
   //MARK: - Start new round And Reset
   func startNewRound() {
      points = 0
      round += 1
      targetValue = Int.random(in: 1...100)

   }
   
   func reset () {
      round      = 1
      score      = 0
      points     = 0
      difference = 0
      
      targetValue = Int.random(in: 1...100)
      
   }

   

   
}
