//
//  RandomCollectionViewCell.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class RandomCollectionViewCell: UICollectionViewCell {
    var box: Box? {
        didSet {
            if let box = box {
                self.backgroundColor = UIColor(hexString: box.color.rawValue)
            }
        }
    }
}
