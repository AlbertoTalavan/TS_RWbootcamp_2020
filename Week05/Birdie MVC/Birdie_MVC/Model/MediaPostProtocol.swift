//
//  MediaPostProtocol.swift
//  Birdie-Final
//
//  Created by Alberto Talaván on 6/18/20.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import Foundation
//import UIKit

// We use this protocol so both text posts and image posts
// can be in the MediaPostsHandler.shared.mediaPosts array
protocol MediaPost {
    var textBody: String? { get set }
    var userName: String { get set }
    var timestamp: Date { get set }
}
