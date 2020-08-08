//
//  ViewController.swift
//  Week11-Animations
//
//  Created by Alberto Talaván on 07/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  //notification view variables
  @IBOutlet weak var notificationView: UIView!
  
  //Animation canvas outlets
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var gokuImage: UIImageView!
  @IBOutlet weak var backgroundView: UIImageView!
  
  //Animations menu outlets
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var squareColourButton: UIButton!
  @IBOutlet weak var squareSizeButton: UIButton!
  @IBOutlet weak var squareTranslationButton: UIButton!

  //Animated constraints
  @IBOutlet private var notificationTopConstraint: NSLayoutConstraint!
  @IBOutlet private var colorTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private var translationLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private var sizeBottomConstraint: NSLayoutConstraint!
  
  //Canvas animated constraints
  @IBOutlet private var gokuLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private var gokuHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var gokuWidthConstraint: NSLayoutConstraint!
  
  
  private var menuIsOpen = false
  private var notificationIsVisible = false
  private var gokuHasFlownBefore = false
  private var backgroundHasBeenChanged = false
  private var sizeHasBeenChanged = false
  private var firstTime = true
  
  private let animator = UIViewPropertyAnimator(duration: 0.4, curve: .linear)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    initialSetup()
  }
  
  private func initialSetup() {
    initializeAnimatedConstraints()
    setButtons()
    setUpNotificationView()
  }
  
//MARK: - Buttons Actions
  @IBAction func toggleMenu(_ sender: UIButton) {
    let animatedConstraints: [NSLayoutConstraint] = [
      colorTrailingConstraint, translationLeadingConstraint, sizeBottomConstraint]
    
    if firstTime {
      playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
      firstTime.toggle()
    }

    menuIsOpen.toggle()
    
    if menuIsOpen {
      playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    } else {
      playButton.setImage(UIImage(systemName: "light.max"), for: .normal)
    }

    animatedConstraints.forEach {
      $0.constant = menuIsOpen ? 44 : -50
    }

    UIView.animate(withDuration: 1/5, delay: 0, options: .curveEaseIn, animations: { self.view.layoutIfNeeded() })

    if !menuIsOpen {
      animator.startAnimation()
    }
  }
  
  @IBAction func changeColour(_ sender: UIButton) {
    notificationAnimation()
    //changing colour animation
    if !backgroundHasBeenChanged {
      animator.addAnimations {
        UIView.animate(withDuration: 1, animations: {
          self.containerView.backgroundColor = .systemOrange
        })
      }
//      UIView.animate(withDuration: 1, animations: {
//        self.containerView.backgroundColor = .systemOrange
//      })
    } else {
      animator.addAnimations {
        UIView.animate(withDuration: 1, animations: {
          self.containerView.backgroundColor = .systemTeal
        })
      }
//      UIView.animate(withDuration: 1, animations: {
//        self.containerView.backgroundColor = .systemTeal
//      })
    }
    backgroundHasBeenChanged.toggle()
    
  }
  
  @IBAction func changeSize(_ sender: UIButton) {
    let initialHeight: CGFloat = 128.0
    let initialWidth: CGFloat = 140.0
    let scaleFactor: (x: CGFloat, y: CGFloat) = (1.4, 1.4)
    
    notificationAnimation()
    
    sizeHasBeenChanged.toggle()
    
    animator.addAnimations {
      self.gokuHeightConstraint.constant = self.sizeHasBeenChanged ? initialHeight * scaleFactor.x : initialHeight
      self.gokuWidthConstraint.constant = self.sizeHasBeenChanged ? initialWidth * scaleFactor.y : initialWidth
      
      
      UIView.animate(withDuration: 1/5, delay: 0, options: .curveEaseIn, animations: { self.view.layoutIfNeeded() })
    }

  }
  
  @IBAction func moveImage(_ sender: UIButton) {
    var maxX = UIScreen.main.bounds.maxX
    if !sizeHasBeenChanged {
      maxX += gokuImage.frame.maxX / 2
    } else {
      maxX = UIScreen.main.bounds.maxX
    }
    
    notificationAnimation()
    
    //moving image animation
    if !gokuHasFlownBefore {
      animator.addAnimations {
        self.gokuImage.image = UIImage(named: "goku")
        UIView.animate(withDuration: 0.4) {
          self.gokuImage.transform = .init(translationX: maxX/2, y: 0)
        }
      }

    } else {
      animator.addAnimations {
        self.gokuImage.image = UIImage(named: "gokuLeading")
        UIView.animate(withDuration: 0.4) {
          self.gokuImage.transform = .init(translationX: 0, y: 0)
        }
      }

    }
    gokuHasFlownBefore.toggle()
  }
  
  //MARK: - Animations
  private func notificationAnimation() {
    if !notificationIsVisible {
      notificationIsVisible = true
      notificationTopConstraint.constant = 20
      
      UIView.animate(withDuration: 1/6, delay: 0, options: .curveEaseIn, animations: {
            self.notificationView.alpha = 1
            self.view.layoutIfNeeded()
          }
      )
      
      notificationTopConstraint.constant = -85
      
      UIView.animate(withDuration: 1/8, delay: 0.4, options: .curveEaseIn, animations: {
            self.notificationView.alpha = 0
            self.view.layoutIfNeeded() }, completion: {_ in
            self.notificationIsVisible = false
        }
      )
    }
  }
  
  private func menuOnOffAnimation() {
    let animatedConstraints: [NSLayoutConstraint] = [
      colorTrailingConstraint, translationLeadingConstraint, sizeBottomConstraint]
    
    animatedConstraints.forEach {
      $0.constant = menuIsOpen ? 44 : -50
    }
    UIView.animate(withDuration: 1/5, delay: 0, options: .curveEaseIn, animations: { self.view.layoutIfNeeded() })
  }
}



//MARK: - Extensions
private extension ViewController {
  private func initializeAnimatedConstraints() {
    notificationTopConstraint.constant = -85
    
    colorTrailingConstraint.constant = -50
    translationLeadingConstraint.constant = -50
    sizeBottomConstraint.constant = -50
    
    
  }
  
  private func setButtons() {
    
    let buttons: [UIButton] = [playButton, squareColourButton, squareSizeButton, squareTranslationButton]
    let colors: [UIColor] = [.systemOrange, .systemRed, .systemPurple, .systemTeal]
    
    buttons.forEach {
      $0.layer.cornerRadius = $0.frame.width / 2
      $0.tintColor = UIColor.white
    }
    
    for button in 0..<buttons.count {
      buttons[button].backgroundColor = colors[button]
    }
    
  }
  
  private func setUpNotificationView() {
    notificationView.alpha = 0
    notificationView.layer.cornerRadius = 10
    notificationView.backgroundColor = .systemGray
  }
  
}


