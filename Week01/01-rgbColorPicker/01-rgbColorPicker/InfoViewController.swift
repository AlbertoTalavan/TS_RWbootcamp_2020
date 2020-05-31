//
//  InfoViewController.swift
//  01-rgbColorPicker
//
//  Created by Alberto Talaván on 31/05/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {
   
   var model: String?
   
   var color: UIColor?
   
   /*
   var v1: Float?
   var v2: Float?
   var v3: Float?
   
   let alpha = CGFloat(1.0)
   */
   
   @IBOutlet weak var webView: WKWebView!
   
   @IBOutlet weak var closeButton: UIButton!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      configureButton()
      simpleNetworkRequest()
      
   }
   
   @IBAction func close (_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   func simpleNetworkRequest(){
      //https://en.wikipedia.org/wiki/RGB_color_model
      //https://en.wikipedia.org/wiki/HSL_and_HSV
      var urlString: String = ""
      let request: URLRequest
      if let model = model {
         if model == "rgb" {
            urlString = "https://en.wikipedia.org/wiki/RGB_color_model"
         }else if model == "hsb" {
            urlString = "https://en.wikipedia.org/wiki/HSL_and_HSV"
         }
         
      } else {
       urlString = "https://en.wikipedia.org/wiki/RGB_color_model"
      }
         
      request = URLRequest(url: URL(string: urlString)!)
      
      webView.load(request)
      
   }
   
   
   @IBAction func closeButtonPressed(_ sender: UIButton) {
      dismiss(animated: true)
   }
   
   
   func configureButton(){
      closeButton.layer.cornerRadius = 5
      closeButton.layer.borderWidth  = 1
      
      closeButton.backgroundColor = color

   }
   /*
   func superViewColor(){
      var color: UIColor
      guard let model = model else { return } // if return background colour stills = .clear
      guard let v1 = v1 else {return}
      guard let v2 = v2 else {return}
      guard let v3 = v3 else {return}
      
      if model == "rgb" {
         color = UIColor(red: CGFloat(v1), green: CGFloat(v2), blue: CGFloat(v3), alpha: alpha)
      }else if model == "hsb" {
          color = UIColor(hue: CGFloat(v1), saturation: CGFloat(v2), brightness: CGFloat(v3), alpha: alpha)
      }else {
         //future code here
         color = UIColor.clear
      }
      
      view.backgroundColor = color
   }
 */
   
}
