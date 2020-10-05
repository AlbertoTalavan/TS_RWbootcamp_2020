//
//  Date+Ext.swift
//  Birdui
//
//  Created by Maitri Mehta on 7/13/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

extension Date {
    func toString(withFormat format: String = "d MMM, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
