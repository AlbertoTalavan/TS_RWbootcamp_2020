//
//  ViewController.swift
//  01-rgbColorPicker
//
//  Created by Alberto Talaván on 29/05/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var colorNameLabel:        UILabel!
   @IBOutlet weak var segmentedControlLabel: UILabel!
   @IBOutlet weak var redHueLabel:           UILabel!
   @IBOutlet weak var greenSaturationLabel:  UILabel!
   @IBOutlet weak var blueBrightnessLabel:   UILabel!
   
   @IBOutlet weak var segmentedColorType: UISegmentedControl!
   
   
   @IBOutlet weak var rhValueLabel: UILabel!
   @IBOutlet weak var gsValueLabel: UILabel!
   @IBOutlet weak var bbValueLabel: UILabel!
   
   @IBOutlet weak var rhSlider: UISlider!
   @IBOutlet weak var gsSlider: UISlider!
   @IBOutlet weak var bbSlider: UISlider!
   
   
   var rhVal = 0 //Int value of the red/hue slider
   var gsVal = 0 //Int value of the green/sat slider
   var bbVal = 0 //Int value of the blue/bright slider
   
   let alpha = 1.0
   
   var firstRun = true
   var myColorName = ""

   enum Model {
      case rgb
      case hsb
   }
   
   @IBOutlet weak var ColorNAmeView: UIView!
   @IBOutlet weak var ColorModelView: UIView!
   @IBOutlet weak var SlidersView: UIView!
   @IBOutlet weak var ButtonsView: UIView!
   
   
   
   //Starting program after loading the view
   override func viewDidLoad() {
      super.viewDidLoad()
      //initial settings
      cleaningContainerViews()
      settings(model: .rgb)
  
   }
   
   //MARK: - Segmented Control
   @IBAction func modeChanged(_ sender: UISegmentedControl){
      if sender.selectedSegmentIndex == 0 { //rgb
         settings(model: .rgb)
      }else if sender.selectedSegmentIndex == 1 { //hsb
         settings(model: .hsb)
      }
   }
   
   
   //MARK: - Sliders
   @IBAction func rhSliderMoved(_ sender: UISlider) {
      let roundedValue = rhSlider.value.rounded()
      rhVal = Int(roundedValue)
      rhValueLabel.text = String(rhVal)
      //todo -> change the background color in real time // func changeBGcolor
   }
   
   @IBAction func gsSliderMoved(_ sender: UISlider) {
      let roundedValue = gsSlider.value.rounded()
      gsVal = Int(roundedValue)
      gsValueLabel.text = String(gsVal)
      //todo -> change the background color in real time // func changeBGcolor
   }
   
   @IBAction func bbSliderMoved(_ sender: UISlider) {
      let roundedValue = bbSlider.value.rounded()
      bbVal = Int(roundedValue)
      bbValueLabel.text = String(bbVal)
      //todo -> change the background color in real time // func changeBGcolor
   }
   
   
   //MARK: - Buttons
   @IBAction func infoPressed(_ sender: UIButton) {
      //segue to the next view
      
   }
   
   @IBAction func setColor(_ sender: UIButton) {
      //show alert view with text view to add a name to our color
   }
   
   @IBAction func reset(_ sender: UIButton) {
      let segment: UISegmentedControl = segmentedColorType
      if segment.selectedSegmentIndex == 0 { settings(model: .rgb) }
      else if segment.selectedSegmentIndex == 1 { settings(model: .hsb)}
      else { /*other future case or cases with else if */}

   }
   
   
   //MARK: - Changing Background Color
   func setBGcolor() {
      //let color: UIColor = .systemGreen
      
      
      
      //view.backgroundColor = color
   }
   
   func calculateColor(model: Model, values: [Int]) -> UIColor {
      
      if model == .rgb {
         
      }else if model == .hsb {
         
      } else {
         //code here for other future value or else if if more than one
      }
      
      return .systemPurple
   }
   
   //MARK: - Setting values after reset or first run
   func settings(model: Model){
      //setting  backgroundColor to default color
      view.backgroundColor = .systemBackground
      
      //Adding appropiate text to color name label
      #warning("Change this with a ranfom function for the first running of the app")
      if firstRun { colorNameLabel.text = "FIRST RUN"; firstRun = false}  //Add a function to randomly pick a color and a name
      else { colorNameLabel.text = myColorName }
      
      //setting sliders labels
      settingSlidersLabels()
      
      //setting min/Max value to sliders
      if model == .rgb {
         assignSliderMinMax(slider: rhSlider, model: .rgb)
         assignSliderMinMax(slider: gsSlider, model: .rgb)
         assignSliderMinMax(slider: bbSlider, model: .rgb)
      }else if model == .hsb{
         assignSliderMinMax(slider: rhSlider, model: .hsb)
         assignSliderMinMax(slider: gsSlider, model: .hsb)
         assignSliderMinMax(slider: bbSlider, model: .hsb)
         
      } else {
         //some code here if we add another model
      }

      
      //initial value of the sliders
      rhSlider.value = rhSlider.minimumValue  //´cos we like to start in the value = 0 (the minimum one)
      gsSlider.value = gsSlider.minimumValue
      bbSlider.value = bbSlider.minimumValue
      
      rhValueLabel.text = String(Int(rhSlider.value))
      gsValueLabel.text = String(Int(gsSlider.value))
      bbValueLabel.text = String(Int(bbSlider.value))
      
      //setting tint of the sliders
      stylingSliders(model: model)
   }
   
   //MARK: - Setting Sliders
   func assignSliderMinMax (slider: UISlider, model: Model) {
      let rgbMax          = 255
      let hueMax          = 360
      let sat_bright_Max  = 100

      //Setting min value -> this is a common value for both types (rgb/hsb)
      slider.minimumValue = 0
      
      //Setting Max value
      if model == .rgb { //IF RGB
         slider.maximumValue = Float(rgbMax) //red,green and blue
         
      }else if model == .hsb{ // IF HSB
         if slider == rhSlider { slider.maximumValue = Float(hueMax) }  // Hue max = 100
         else { slider.maximumValue = Float(sat_bright_Max)}            //saturation and brightness max = 360
         
      } else {
         //some code here if we add another model or else if´s if we continue adding different ones
      }
   }
   
   func stylingSliders(model: Model) {
      //setting min/Max value to sliders
      if model == .rgb {
         rhSlider.tintColor = .systemRed ;   rhSlider.thumbTintColor = .systemRed
         gsSlider.tintColor = .systemGreen;  gsSlider.thumbTintColor = .systemGreen
         bbSlider.tintColor = .systemBlue;   bbSlider.thumbTintColor = .systemBlue
      }else if model == .hsb{
         rhSlider.tintColor = .systemOrange; rhSlider.thumbTintColor = .systemOrange
         gsSlider.tintColor = .systemPink;   gsSlider.thumbTintColor = .systemPink
         bbSlider.tintColor = .label;        bbSlider.thumbTintColor = .label
         

      }
      else {
         //some code here if we add other model (or -else if- if we add more than one
      }

   }
   
   func settingSlidersLabels() {
      let segment = segmentedColorType.selectedSegmentIndex
      let model: Model
      
      switch segment {
         case 0:
            model = .rgb
         case 1:
            model = .hsb
         default:
            model = .rgb
      }
      
      if model == .rgb {
         redHueLabel.text           = "Red"
         greenSaturationLabel.text  = "Green"
         blueBrightnessLabel.text   = "Blue"
         
      } else if model == .hsb{
         redHueLabel.text           = "Hue"
         greenSaturationLabel.text  = "Saturation"
         blueBrightnessLabel.text   = "Brightness"
         
      } else {
         //some code here if we add another model
      }
   }
   
   
   //MARK: -Other Auxiliary functions
   func cleaningContainerViews() {
      ColorNAmeView.backgroundColor    = .clear
      ColorModelView.backgroundColor   = .clear
      SlidersView.backgroundColor      = .clear
      ButtonsView.backgroundColor      = .clear
   }
}

