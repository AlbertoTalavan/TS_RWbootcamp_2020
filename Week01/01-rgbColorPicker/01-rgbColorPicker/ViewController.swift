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
   
   
   var rhVal: Float = 0.0 //Int value of the red/hue slider
   var gsVal: Float = 0.0 //Int value of the green/sat slider
   var bbVal: Float = 0.0 //Int value of the blue/bright slider
   
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
      settingUI(model: .rgb)
  
   }
   
   //MARK: - Segmented Control
   @IBAction func modeChanged(_ sender: UISegmentedControl){
      if sender.selectedSegmentIndex == 0 { //rgb
         settingUI(model: .rgb)
      }else if sender.selectedSegmentIndex == 1 { //hsb
         settingUI(model: .hsb)
      }
   }
   
   
   //MARK: - Sliders
   @IBAction func rhSliderMoved(_ sender: UISlider) {
      let roundedValue = rhSlider.value.rounded()
      rhVal = roundedValue
      rhValueLabel.text = String(Int(rhVal))
      
      setBGcolor() //changing bgcolor in real time
   }
   
   @IBAction func gsSliderMoved(_ sender: UISlider) {
      let roundedValue = gsSlider.value.rounded()
      gsVal = roundedValue
      gsValueLabel.text = String(Int(gsVal))
      
      setBGcolor() //changing bgcolor in real time
   }
   
   @IBAction func bbSliderMoved(_ sender: UISlider) {
      let roundedValue = bbSlider.value.rounded()
      bbVal = roundedValue
      bbValueLabel.text = String(Int(bbVal))
      
      setBGcolor() //changing bgcolor in real time
   }
   
   
   //MARK: - Buttons
   @IBAction func infoPressed(_ sender: UIButton) {
      //segue to the next view
      
   }
   
   @IBAction func setColor(_ sender: UIButton) {
      //show alert view with text view to add a name to our color
      showAlertView()
      
   }
   
   @IBAction func reset(_ sender: UIButton) {
      let segment: UISegmentedControl = segmentedColorType
      if segment.selectedSegmentIndex == 0 { settingUI(model: .rgb) }
      else if segment.selectedSegmentIndex == 1 { settingUI(model: .hsb)}
      else { /*other future case or cases with else if */}

   }
   
   
   //MARK: - Changing Background Color
   #warning("this func shouls return a random color in range")
   func initialColor() -> UIColor {
      let v1 = rhSlider.value
      let v2 = gsSlider.value
      let v3 = bbSlider.value
      
      return .systemBackground
   }
   
   func setBGcolor() {
      if segmentedColorType.selectedSegmentIndex == 0 {
         view.backgroundColor = calculateColor(model: .rgb)
      } else if segmentedColorType.selectedSegmentIndex == 1 {
         view.backgroundColor = calculateColor(model: .hsb)
      } else {
         view.backgroundColor = .systemBackground
      }
      
   }
   
   func calculateColor(model: Model) -> UIColor {
      //slider values are stored en rhVal, gsVal and bbVal
      var v1 = rhVal
      var v2 = gsVal
      var v3 = bbVal
      
      let rgbMax     = Float(255)
      let hueMax     = Float(360)
      let satMax     = Float(100)
      let brightMax  = Float(100)
      
      var color = UIColor() //Need to create it here bc I´m not using the -else- case in the if-else
      
      if model == .rgb {
         v1 = v1/rgbMax
         v2 = v2/rgbMax
         v3 = v3/rgbMax
         color = UIColor(red: CGFloat(v1), green: CGFloat(v2), blue: CGFloat(v3), alpha: CGFloat(alpha))
      }
      else if model == .hsb {
         v1 = v1/hueMax
         v2 = v2/satMax
         v3 = v3/brightMax
         color = UIColor(hue: CGFloat(v1), saturation: CGFloat(v2), brightness: CGFloat(v3), alpha: CGFloat(alpha))
      }
      else {
         //code here for other future value or else if if more than one
      }

      return color
   }
   
   
   
   //MARK: - Setting values after reset or first run
   func settingUI(model: Model){
      //Setting colour global values to zero
      resetColourGlobalValues()
      
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
      
      //setting  backgroundColor to default color
      view.backgroundColor = initialColor()
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
         bbSlider.tintColor = .label;        bbSlider.thumbTintColor = .systemGray3
         

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
   
   func resetColourGlobalValues() {
      rhVal = 0
      gsVal = 0
      bbVal = 0
   }

   
   //MARK: - Show Alert
   func showAlertView() {
      var alertText = UITextField() //storage for the alertTextField of addAlertTextfield()
      
      let alert = UIAlertController(title: "Give this colour a name", message: "Type the most original name for your new colour creation", preferredStyle: .alert)
      
      let actionOK = UIAlertAction(title: "🔥like it", style: .default) { action in
         let segment = self.segmentedColorType.selectedSegmentIndex
         let model: Model
         
         switch segment {
            case 0:
               model = .rgb
            case 1:
               model = .hsb
            default:
               model = .rgb
         }
         

         self.ColorNAmeView.backgroundColor = self.calculateColor(model: model)
         self.myColorName = {
            if alertText.text == "" { return "My Fav Colour"}
            return alertText.text ?? "Unknown"
         }()

         self.settingUI(model: model) //resetting after press the actionOK button of the alert
         
      }
      
      
      let actionCancel = UIAlertAction(title: "meh! 😓", style: .destructive, handler: nil)
      
      
      alert.addAction(actionOK)
      alert.addAction(actionCancel)
      
      alert.addTextField { textField in
         textField.placeholder = "Type the best name for your creation..."
         alertText = alert.textFields![0]
      }
      
      present(alert, animated: true)  //completion not needed
   }
   
   
   //MARK: - auxiliary print functions
   func printColor(model: Model?, color: [Float]) {
      print()
      print("## model : \(model)")
      print("## original values ===> rh: \(rhVal), gs: \(gsVal), bb: \(bbVal), alpha: \(alpha)")
      print("## formatted values ==> rh: \(color[0]), gs: \(color[1]), bb: \(color[2]), alpha: \(alpha)")
      print()
      
   }
}

