//
//  ImagePostModel.swift
//  Birdie-Final
//
//  Created by Alberto Talaván on 6/18/20.
//  Copyright © 2020 Alberto Talavánn. All rights reserved.
//

import UIKit

struct ImagePost: MediaPost {
    var textBody: String?
    var userName: String
    var timestamp: Date
    var image: UIImage
}


