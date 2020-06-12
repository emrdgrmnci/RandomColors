//
//  UIColor+Array.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 13.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    func randomElement() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}

extension UIColor {
    enum ColorEnum: String {
        case systemRed   // = "red"
        case systemGreen // = "green"
        case systemBlue  // = "blue"
        case systemPink  // = "pink"

        func toColor() -> UIColor {
            switch self {
            case .systemRed:
                return .systemRed
            case .systemGreen:
                return .green
            case .systemBlue:
                return .blue
            case .systemPink:
                return UIColor(hue: 1.0, saturation: 0.25, brightness: 1.0, alpha: 1.0)
            }
        }
    }

    static func fromString(name: String) -> UIColor? {
        return ColorEnum(rawValue: name)?.toColor()
    }
}



