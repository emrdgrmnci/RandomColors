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

    var boxNumber: Int?
    var selectedBox: Box!
    var allColors: [Box] = [SystemRed(), SystemGreen(), SystemYellow(), SystemBlue()]

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }

    //MARK: - updateLayout()
    func updateLayout() {
        boxName.text = NSLocalizedString("\(boxNumber ?? 0) numaralı \(selectedBox.boxName ) renkli kutu", comment: "")
        boxDescription.text =  NSLocalizedString("Renk kodu: \(Lorem.dummy.rawValue)", comment: "")
        boxName.backgroundColor = UIColor(hexString: selectedBox.color.rawValue)
    }

    //MARK: - changeBoxColor button
    @IBAction func changeBoxColorButton(_ sender: Any) {
        let currentColor = selectedBox.color
        selectedBox = allColors.randomElement()
        updateLayout()
        NotificationCenter.default.post(name: Notification.Name("UpdateBox"), object: nil, userInfo: ["prevColor": selectedBox!.color, "currColor": currentColor])

    }
}
