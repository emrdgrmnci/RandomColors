//
//  DetailViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Variables
    @IBOutlet weak var boxName: UILabel!
    @IBOutlet weak var boxDescription: UILabel!
    @IBOutlet weak var changeColorButton: UIButton!

    var boxNumber: Int?
    var selectedBox: Box!
    var allColors: [Box] = [SystemRed(), SystemGreen(), SystemYellow(), SystemBlue()]

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    //MARK: - updateUI()
    func updateUI() {
        boxName.text = String(format: NSLocalizedString("Number %d %@ color box", comment: ""),"\(boxNumber ?? 0)", "\(selectedBox.boxName)")
        boxDescription.text = String(format: NSLocalizedString("Description: %@", comment: ""), "\(Lorem.dummy.rawValue)")
        boxName.backgroundColor = UIColor(hexString: selectedBox.color.rawValue)
        changeColorButton.backgroundColor = UIColor(hexString: selectedBox.color.rawValue)
    }

    //MARK: - changeBoxColor button
    @IBAction func changeBoxColorButton(_ sender: Any) {
        let currentColor = selectedBox.color
        selectedBox = allColors.randomElement()
        updateUI()
        NotificationCenter.default.post(name: Notification.Name("UpdateBox"), object: nil, userInfo: ["prevColor": selectedBox!.color, "currColor": currentColor])

    }
}
