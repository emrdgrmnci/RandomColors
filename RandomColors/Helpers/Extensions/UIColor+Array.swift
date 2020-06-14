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
        case systemRed
        case systemGreen
        case systemBlue
        case systemPink
        case systemTeal
        case systemYellow

        func toColor() -> UIColor {
            switch self {
            case .systemRed:
                return .systemRed
            case .systemGreen:
                return .systemGreen
            case .systemBlue:
                return .systemBlue
            case .systemPink:
                return .systemPink
            case .systemTeal:
                return .systemTeal
            case .systemYellow:
                return .systemYellow

            }
        }
    }

    static func fromString(name: String) -> UIColor? {
        return ColorEnum(rawValue: name)?.toColor()
    }
}



