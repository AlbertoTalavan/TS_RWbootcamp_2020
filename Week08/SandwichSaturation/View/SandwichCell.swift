///
///  Created by Jeff Rames on 7/3/20.
///
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class SandwichCell: UITableViewCell {
  @IBOutlet weak var thumbnail: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var sauceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
    
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
