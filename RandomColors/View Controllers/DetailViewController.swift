//
//  DetailViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var boxName: UILabel!
    @IBOutlet weak var boxDescription: UILabel!

    var boxNumber: Int?
    var color: String?
    var boxNameBackgroundColor: UIColor?

//    let randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        boxName.text = "\(boxNumber ?? 0) numaralı kutu detayı"
        boxDescription.text = color
        boxName.backgroundColor = boxNameBackgroundColor
    }

    //TODO: - Change color of the selected box
    @IBAction func changeBoxColor(_ sender: Any) {
        boxName.backgroundColor = UIColor.fromString(name: colors.randomElement())
    }
}
