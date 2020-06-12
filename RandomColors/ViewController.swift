//
//  ViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var randomColors: [UIColor] = [.red, .yellow, .purple, .blue]

    @IBOutlet weak var collectionView: UICollectionView!

    private var indexPath: IndexPath = []


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    @IBAction func refreshButton(_ sender: Any) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCollectionViewCell", for: indexPath) as? RandomCollectionViewCell else {
                   fatalError("Unable to dequeue PersonCell.")
               }
               cell.backgroundColor = .random()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCollectionViewCell", for: indexPath) as? RandomCollectionViewCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        cell.backgroundColor = .random()
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        navigationController?.pushViewController(vc, animated: true)

    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}
