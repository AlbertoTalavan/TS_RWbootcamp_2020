//
//  ViewController.swift
//  BullsEye
//
//  Created by Alberto Talaván on 07/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
   @IBOutlet weak var targetLabel: UILabel!
   @IBOutlet weak var targetTextLabel: UILabel!
   @IBOutlet weak var guessLabel: UILabel!
   
   @IBOutlet weak var redLabel: UILabel!
   @IBOutlet weak var greenLabel: UILabel!
   @IBOutlet weak var blueLabel: UILabel!
   
   @IBOutlet weak var redSlider: UISlider!
   @IBOutlet weak var greenSlider: UISlider!
   @IBOutlet weak var blueSlider: UISlider!
   
   @IBOutlet weak var roundLabel: UILabel!
   @IBOutlet weak var scoreLabel: UILabel!
   
   @IBOutlet weak var hintLabel: UILabel!
   @IBOutlet weak var hintSwitch: UISwitch!
   
   @IBOutlet weak var hitmeButton: UIButton!
   
   let game        = BullsEyeGame()
   var rgbTarget   = RGB()
   var rgbAspirant = RGB()
   
   var hintIsShowed = false
   var lastScores: Array<Int> = []  //declare this way just to practice
                                    //same as var lastScores = [Int]()
   
   var quickDiff: Int { //slider Hint
      abs(game.getTargetValue() - game.getCurrentValue())
   }
   
   
   //MARK: - View Methods
   override func viewDidLoad() {
      super.viewDidLoad()
      stylingButton(hitmeButton)
      startOver()
      
      
   }
   
   
   //MARK: - Actions
   @IBAction func aSliderMoved(sender: UISlider) {
      let roundedValue = sender.value.rounded() //OK
      switch sender {
         case redSlider:
            rgbAspirant.r = Int(roundedValue)
            redLabel.text = String(rgbAspirant.r)
            guessLabel.backgroundColor = UIColor.init(rgbStruct: rgbAspirant)
            applyHint(to: redSlider)
            //sliderHint(blueSlider)
         case greenSlider:
            rgbAspirant.g = Int(roundedValue)
            greenLabel.text = String(rgbAspirant.g)
            guessLabel.backgroundColor = UIColor.init(rgbStruct: rgbAspirant)
            applyHint(to: greenSlider)
         case blueSlider:
            rgbAspirant.b = Int(roundedValue)
            blueLabel.text = String(rgbAspirant.b)
            guessLabel.backgroundColor = UIColor.init(rgbStruct: rgbAspirant)
            applyHint(to: blueSlider)
         default:
            break
      }
   }

   @IBAction func showAlert(sender: AnyObject) {
      
      let tuple: (title: String, message: String, buttonMessage: String) = alertViewStringComponents()
      
      //need to change the aligment of the alert view message
      let  paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .left
      
      let alertMessage = NSMutableAttributedString (
          string: tuple.message,
          attributes:[NSAttributedString.Key.paragraphStyle: paragraphStyle])
      
      let alertTitle = NSMutableAttributedString (
               string: tuple.title,
               attributes:[NSAttributedString.Key.paragraphStyle: paragraphStyle,
                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)])
      
      
      //alert view
      let alert = UIAlertController(
         title: tuple.title,
         message: nil,
         preferredStyle: .alert)
      
      let action = UIAlertAction(title: tuple.buttonMessage, style: .default) { (action) in
         self.addScore(add: self.game.getPoints())
         self.addLastScore(score: self.game.getPoints())
         self.startNewRound()
         self.updateViews()
      }
      
      alert.addAction(action)
      
      //applying message aligment = .left
      alert.setValue(alertTitle, forKey: "attributedTitle")
      alert.setValue(alertMessage, forKey: "attributedMessage")
      
      
      
      present(alert, animated: true, completion: nil)
   }

   @IBAction func startOver() {
      reset()
      updateViews()
   }
   
   @IBAction func switchMoved(sender: UISwitch){
      if !hintSwitch.isOn { slidersDefaultColor(); }
      else { applyHintAllSliders()}
   }
   
   //MARK: - Slider Hint
   func showHint(){
      if hintIsShowed == false {
         hintLabel.isHidden  = true
         hintSwitch.isHidden = true
         slidersDefaultColor()
      }else {
         hintLabel.isHidden  = false
         hintSwitch.isHidden = false
         hintSwitch.isOn = true
         applyHintAllSliders()        //not sure if strictly necessary here
      }
   }
   
   func addLastScore(score points: Int) {
      if lastScores.count >= 2 {
         lastScores.removeFirst()
      }
      lastScores.append(points)
   }
   
   func checkLastScores(){
      if lastScores != [] {
         if lastScores[lastScores.count - 1] >= 100 {
            hintIsShowed = false
            hintSwitch.isOn = false
         }
      }
      if lastScores.count >= 2 {
         if lastScores[0] <= 85 && lastScores[1] <= 85 {
            hintIsShowed = true
         } else {
            hintIsShowed = false
         }
      }
      
   }

   func sliderHint(_ sender: UISlider) {
      var color = UIColor()

      switch sender {
         case redSlider:
            game.setTargetValue(to: rgbTarget.r)
            game.setCurrentValue(to: rgbAspirant.r)
            color = UIColor.red.withAlphaComponent(CGFloat(quickDiff)/100.0)
         case greenSlider:
            game.setTargetValue(to: rgbTarget.g)
            game.setCurrentValue(to: rgbAspirant.g)
            color = UIColor.green.withAlphaComponent(CGFloat(quickDiff)/100.0)
         case blueSlider:
            game.setTargetValue(to: rgbTarget.b)
            game.setCurrentValue(to: rgbAspirant.b)
            color = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
         default: break
      }

      sender.minimumTrackTintColor = color
   }
   
   
   
   func applyHint(to slider: UISlider) {
      if hintIsShowed && hintSwitch.isOn == true {
         sliderHint(slider)
      } else {
         slidersDefaultColor()
      }
   }
   
   func applyHintAllSliders() {
      sliderHint(redSlider)
      sliderHint(greenSlider)
      sliderHint(blueSlider)
   }
   
   func slidersDefaultColor() {
      redSlider.minimumTrackTintColor = UIColor.systemRed
      greenSlider.minimumTrackTintColor = UIColor.systemGreen
      blueSlider.minimumTrackTintColor = UIColor.systemBlue
   }
   

   //MARK: - Game Core Functionality
   func alertViewStringComponents() -> (String, String, String) {

      let title: String
      let message: String
      let hitMeText: String
      var extraPoints: Int = 0
      let spacing: String = "\n"
      let expMessage: String = "\nCorrect values were:"
      let expMessage2: String = "\nr: \(rgbTarget.r), g: \(rgbTarget.g),b: \(rgbTarget.b)"
      
      
      let rgbDifference = rgbAspirant.difference(target: rgbTarget)
      let difference    = Int (rgbDifference * 100.0)
         print("rgbDifference: \(rgbDifference)")
         print("difference...: \(difference)")
      
      if difference == 0 {
         title = "Perfect!"
         extraPoints += 100
         hitMeText = "I´m the best"
      }else if difference == 1 {
         title = "You almost had it!"
         extraPoints += 50
         hitMeText = "I rock!"
      }else if difference < 5 {
         title = "You almost had it!"
         hitMeText = "pretty awesome"
      } else if difference < 10 {
         title = "Pretty good!"
         hitMeText = "awesome"
      } else {
         title = "meh!, not even close!"
         hitMeText = "mmm allright"
      }
      
      //adding total points after getting extraPoints
      addPoints(add: 100 - difference + extraPoints)
      
      message = spacing + "You scored: \(game.getPoints())" + spacing + expMessage + expMessage2
      
      
      return (title, message, hitMeText)
   }

      
   //MARK: - Score and Points (adding a value)
   func addScore(add value: Int) {
      let score = game.getScore()
      game.setScore(to: score + value)  //updating the score
   }
   
   func addPoints(add value: Int) {
      let points = game.getPoints()
      game.setPoints(to: points + value)
   }
   
   
   //MARK: - Start new round And Resets
   func startNewRound() {
      nextRound()
      game.setPoints(to: 0)
      
      //resetting rgb structs properties
      rgbAspirant.setDefaultValues()
      rgbTarget.setRandomValues()
      
      //checking if hint necessary
      checkLastScores()
      
   }
   
   func reset() {
      //resetting Model properties
      game.setScore(to: 0)

      //resetting rgbLabels
      resetRGBLabels()
      
      //new round
      startNewRound()
      
   }
   
   func resetRGBLabels() {
      redLabel.text   = String(rgbAspirant.r)
      greenLabel.text = String(rgbAspirant.g)
      blueLabel.text  = String(rgbAspirant.b)
   }
   
   func nextRound() {
      let round = game.getRound()
      game.setRound(to: round + 1)
   }
   
 
   // Update Views
   func updateViews() {
      //updating targetLabel bg color
      targetLabel.backgroundColor = UIColor.init(rgbStruct: rgbTarget)
      guessLabel.backgroundColor = UIColor.init(rgbStruct: rgbAspirant)
      
      //updatting sliders position
      redSlider.value   = Float(rgbAspirant.r)
      greenSlider.value = Float(rgbAspirant.g)
      blueSlider.value  = Float(rgbAspirant.b)
      
      //updating sliders Hint
      sliderHint(redSlider)
      sliderHint(greenSlider)
      sliderHint(blueSlider)
      
      //updatting labels
      scoreLabel.text  = "Score: \(game.getScore())"
      roundLabel.text  = "Round: \(game.getRound())"
      
      //showing Hint if needed
      showHint()
      
      
      //crossfade transition
      let transition = CATransition()
      transition.type = CATransitionType.fade
      transition.duration = 1
      transition.timingFunction = CAMediaTimingFunction(name:
         CAMediaTimingFunctionName.easeOut)
      view.layer.add(transition, forKey: nil)
      
   }
   
   func stylingButton(_ button: UIButton) {
      button.layer.cornerRadius = 15
   }
   
   
   
}


