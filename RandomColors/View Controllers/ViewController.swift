//
//  ViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

public let colors = ["systemRed", "systemGreen", "systemBlue", "systemPink"]

class ViewController: UIViewController {

    //    private var randomColors: [UIColor] = [.red, .yellow, .purple, .blue]
    //
    //    let randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])

    @IBOutlet weak var collectionView: UICollectionView!

    private var indexPath: IndexPath = []

    var selectedColorInfo: UIColor?


    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView?.collectionViewLayout as? RandomColorsLayout {
            layout.delegate = self
        }

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @IBAction func refreshButton(_ sender: Any) {
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCollectionViewCell", for: indexPath) as? RandomCollectionViewCell else {
            fatalError("Unable to dequeue RandomCell.")
        }

        cell.backgroundColor = UIColor.fromString(name: colors.randomElement())
        selectedColorInfo = cell.backgroundColor
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.boxNumber = indexPath.row
        vc.color = "\(selectedColorInfo ?? .white)"
        vc.boxNameBackgroundColor = selectedColorInfo


        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let widths = [100, 130, 200, 170, 150]
        let number = widths[Int(arc4random_uniform(UInt32(widths.count)))]
        let height: Double = Double((1080 / 1920) * number)
        let size = CGSize(width: number, height: Int(height))
        return size
    }
}

extension ViewController: RandomColorsLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
//        return 130
//    }
    func collectionView(_ collectionView: UICollectionView, heightForBoxAtIndexPath indexPath: IndexPath) -> CGFloat {

      let randomCGFloat = Int.random(in: 5...10)
      let newInt = randomCGFloat * 15
      return CGFloat(newInt)
    }
}
