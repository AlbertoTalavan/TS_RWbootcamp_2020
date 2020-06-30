//
//  CustomCell.swift
//  Birdie-MVC-Final
//
//  Created by Alberto Talaván on 27/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

   
   @IBOutlet weak var badgeImage: UIImageView!
   @IBOutlet weak var multimedia: UIImageView!
   
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var timeStampLabel: UILabel!
   @IBOutlet weak var textBodyLabel: UILabel!
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
