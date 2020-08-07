//
//  ViewController.swift
//  Week11-Animations
//
//  Created by Alberto Talaván on 07/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var squareColourButton: UIButton!
  @IBOutlet weak var squareSizeButton: UIButton!
  @IBOutlet weak var squareTranslationButton: UIButton!
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var gokuImage: UIImageView!
  
  private var menuIsOpen = false
  @IBOutlet private var colorTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private var translationLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private var sizeBottomConstraint: NSLayoutConstraint!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setButtons()
  }

  @IBAction func toggleMenu(_ sender: UIButton) {
    menuIsOpen.toggle()
    let animatedConstraints: [NSLayoutConstraint] = [
    colorTrailingConstraint, translationLeadingConstraint, sizeBottomConstraint]
    
    animatedConstraints.forEach {
      $0.constant = menuIsOpen ? 44 : -50
    }
    
    UIView.animate(withDuration: 1/5, delay: 0, options: .curveEaseIn, animations: { self.view.layoutIfNeeded() })
    
  }
  
  
  

}

private extension ViewController {
  func initializeAnimatedConstraints() {
    colorTrailingConstraint.constant = -50
    translationLeadingConstraint.constant = -50
    sizeBottomConstraint.constant = -50
  }
  
  func setButtons() {
    initializeAnimatedConstraints()
    
    let buttons: [UIButton] = [playButton, squareColourButton, squareSizeButton, squareTranslationButton]
    
    buttons.forEach {
      $0.layer.cornerRadius = $0.frame.width / 2
      $0.tintColor = UIColor.white
    }
    buttons[0].backgroundColor = .systemOrange
    buttons[1].backgroundColor = .systemRed
    buttons[2].backgroundColor = .systemPurple
    buttons[3].backgroundColor = .systemTeal
  }
  
  
}

