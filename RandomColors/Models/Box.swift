//
//  Box.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 14.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit.UIColor

protocol Box: class {
    var height: Float { get set }
    var boxName: String { get set }
    var boxNumber: Int { get set }
    var description: String { get set }
    var color: Color { get set }
}

enum Color: String, CaseIterable {
    case systemRed = "#FF3B30"
    case systemGreen = "#34C759"
    case systemYellow = "#FFCC00"
    case systemBlue = "#007AFF"
}
