//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
// Debugging exercise solved by Alberto Talaván 18/06/20
//


import UIKit

class ViewController: UIViewController {

    // Left
    @IBOutlet weak var titleLabelLeft: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var priceLabelLeft: UILabel!
    @IBOutlet weak var roomLabelLeft: UILabel!   //It was disconnected  of roomLabelLeft on the Story Board

    // Right
    @IBOutlet weak var titleLabelRight: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var priceLabelRight: UILabel!
    @IBOutlet weak var roomLabelRight: UILabel!

    var house1: House?
    var house2: House?

    override func viewDidLoad() {
            super.viewDidLoad()
          house1 = House() //we need to create it before give a value to its properties
            
          house1?.address = "3898 Melody Ln, Santa Clara CA" //we need to add a value bc in setUpLeftSideUI() we have forced unwraps
            house1?.price = "$12,000"
            house1?.bedrooms = "3 bedrooms"
          
          setUpLeftSideUI()
          setUpRightSideUI()

        }

        func setUpLeftSideUI() {
         titleLabelLeft.text = house1!.address! //here we could create a secure unwrap using guard or if let
            priceLabelLeft.text = house1!.price!   //to be sure that at this point we have a non nill value for house1
            roomLabelLeft.text = house1!.bedrooms! //and in case we have it, take the proper considerations (default value, etc...)
                                                   //we could even use the conditional ? to avoid any app crash, but in this case
                                                   //we would have a nill value for house1 and (in this particular case) only the image would be shown on screen (because we do not have any value for any label)
        }

        func setUpRightSideUI() {
            if house2 == nil {
                titleLabelRight.alpha = 0  //we could refactor this part if we create an array containing all the labels...
                imageViewRight.alpha = 0   //"labelsArray: [UILabel]" and later do "labelsArray.map { $0.alpha = 1.0}"
                priceLabelRight.alpha = 0
                roomLabelRight.alpha = 0
            } else {
                titleLabelRight.text! = house2!.address!
                priceLabelRight.text! = house2!.price!
                roomLabelRight.text! = house2!.bedrooms!
               
               titleLabelRight.alpha = 1.0 //First time we get to this function, we have an optional house2 so...
               imageViewRight.alpha  = 1.0 //when we have a non nil house2 we need to re-set the alpha values
               priceLabelRight.alpha = 1.0 //we could refactor this part if we create an array containing all the labels...
               roomLabelRight.alpha  = 1.0 // "labelsArray: [UILabel]" and later do "labelsArray.map { $0.alpha = 1.0}"
               
            }
        }

        @IBAction func didPressAddRightHouseButton(_ sender: Any) {
            openAlertView()
        }

        func openAlertView() {
            let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

            alert.addTextField { (textField) in
                textField.placeholder = "address"
            }

            alert.addTextField { (textField) in
                textField.placeholder = "price"
            }

            alert.addTextField { (textField) in
                textField.placeholder = "bedrooms"
            }

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
                var house = House()
               
               alert.textFields?.forEach {
                  //checking for "" values in textfields (empty values means we didn´t type anything inside them)
                  if $0.text == "" { $0.text = "\(String(describing: $0.placeholder!)) not available" }
               }
                house.address = alert.textFields?[0].text
                house.price = alert.textFields?[1].text
                house.bedrooms = alert.textFields?[2].text
                self.house2 = house
                self.setUpRightSideUI()
            }))

            self.present(alert, animated: true, completion: nil)
        }

    }

    struct House {
        var address: String?
        var price: String?
        var bedrooms: String?
    }
