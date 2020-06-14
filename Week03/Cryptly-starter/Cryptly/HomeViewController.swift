//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 13/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController{

  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  let cryptoData = DataGenerator.shared.generateData()
    
  
  //MARK: - ViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    

    setupViews()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  

  //MARK: - Setting Up Views
  func setupViews() {
      
    //view1.backgroundColor = .systemGray6
    //view1.layer.borderColor = UIColor.lightGray.cgColor
    view1.layer.borderWidth = 1.0
    view1.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    view1.layer.shadowOffset = CGSize(width: 0, height: 2)
    view1.layer.shadowRadius = 4
    view1.layer.shadowOpacity = 0.8
    
    //view2.backgroundColor = .systemGray6
    //view2.layer.borderColor = UIColor.lightGray.cgColor
    view2.layer.borderWidth = 1.0
    view2.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    view2.layer.shadowOffset = CGSize(width: 0, height: 2)
    view2.layer.shadowRadius = 4
    view2.layer.shadowOpacity = 0.8
    
    //view3.backgroundColor = .systemGray6
    //view3.layer.borderColor = UIColor.lightGray.cgColor
    view3.layer.borderWidth = 1.0
    view3.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    view3.layer.shadowOffset = CGSize(width: 0, height: 2)
    view3.layer.shadowRadius = 4
    view3.layer.shadowOpacity = 0.8
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func setView1Data() {
    //var currenciesString: String
    //let currenciesName = cryptoData.map { $0.map { ($0.name) }}
    let currenciesName = cryptoData?.map({ (currency)in
      currency.name
    })
    
    guard let currencies = currenciesName else { return }
    view1TextLabel.text = currencies.joined(separator: ", ")

  }
  
  func setView2Data() {

    let currenciesName = cryptoData.map { $0 }?.filter { $0.currentValue > $0.previousValue}.map { $0.name }

    guard let currencies = currenciesName else { return }
    view2TextLabel.text = currencies.joined(separator: ", ")
  }
  
  func setView3Data() {
    // cryptoData has the data
    let currenciesName = cryptoData.map { $0 }?.filter { $0.currentValue < $0.previousValue}.map { $0.name }
     
    guard let currencies = currenciesName else { return }
    view3TextLabel.text = currencies.joined(separator: ", ")
  }
  
  
  //MARK: - Actions
  @IBAction func switchPressed(_ sender: Any) {
    themeChanged()
  }
  
  //MARK: - UI set up due to switch
  func checkDeviceTheme() {
    if traitCollection.userInterfaceStyle == .light {
      themeSwitch.isOn = false
    } else {
      themeSwitch.isOn = true
    }
  }
  
  func settingUI(theme: Theme) {
    //main View
    view.backgroundColor     = theme.backgroundColor
    
    //heading label
    headingLabel.textColor   = theme.textColor
    
    //view1
    view1.backgroundColor    = theme.widgetBackgroundColor
    view1.layer.borderColor  = theme.borderColor.cgColor
    view1TextLabel.textColor = theme.textColor
    
    //view2
    view2.backgroundColor    = theme.widgetBackgroundColor
    view2.layer.borderColor  = theme.borderColor.cgColor
    view2TextLabel.textColor = theme.textColor
    
    //view3
    view3.backgroundColor    = theme.widgetBackgroundColor
    view3.layer.borderColor  = theme.borderColor.cgColor
    view3TextLabel.textColor = theme.textColor
  }
  
}



//MARK: - Extension
extension HomeViewController: Themable {
  func registerForTheme() {
    // should use NotificationCenter to add the current object as an observer for when the “themeChanged” notification occurs. See the hint at the end of this document for some code you can use here.
    
    NotificationCenter.default.addObserver(self, selector: #selector (themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    //should remove the current object as an observer. We have a handy hint for this too. :
    NotificationCenter.default.removeObserver(self)
    
  }
  
  @objc func themeChanged() {
    if themeSwitch.isOn { settingUI(theme: DarkTheme()) }
    else { settingUI(theme: LightTheme()) }
  }
  
  
}
