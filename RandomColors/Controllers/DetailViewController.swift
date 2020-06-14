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
    var color: String?
    var boxNameBackgroundColor: UIColor?
    var vc = ViewController()
    var indexPath: IndexPath?
    var randColor: String = ""
    var height: Int = 0

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        boxName.text = "\(boxNumber ?? 0) numaralı kutu detayı"
        boxDescription.text = "Renk kodu: \(color ?? "")"
        boxName.backgroundColor = boxNameBackgroundColor
    }

    override func viewDidDisappear(_ animated: Bool) {
        vc.changeDetailBox(of: .black, height: height)
    }

    //MARK: - changeBoxColor button
    @IBAction func changeBoxColorButton(_ sender: Any) {
        randColor = colors.randomElement().rawValue
        boxName.backgroundColor = UIColor.fromString(name: randColor)

    }

}
