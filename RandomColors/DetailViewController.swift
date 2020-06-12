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

    private let randomColors: [UIColor] = [.systemRed, .systemYellow, .systemPink, .systemBlue]
    let randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //TODO: - Change color of the selected box
    @IBAction func changeColorOfBox(_ sender: Any) {
        boxName.backgroundColor = randomColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
