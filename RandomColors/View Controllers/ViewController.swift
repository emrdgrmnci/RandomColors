//
//  ViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

struct Box {
    var width: Int
    var height: Int
    var color: UIColor
}

//MARK: - Global constant
let colors = StaticColors.allCases

final class ViewController: UIViewController {

    //MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!
    private var indexPath: IndexPath = []
    private var selectedColorInfo: UIColor?
    private let randomItemsInSection = Int.random(in: 10...30)
    private var cellHeightAndColors = Dictionary<CGFloat, UIColor>()

    static var boxes = [Box]()

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        randomStaticBox()

        if let layout = collectionView?.collectionViewLayout as? RandomColorsLayout {
            layout.delegate = self
        }
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    //MARK: - randomStaticBox()
    func randomStaticBox() {
        ViewController.boxes = []
        let heights = [100, 150, 200, 250, 300]
        for _ in 1...30 {
            let number = heights[Int(arc4random_uniform(UInt32(heights.count)))]
            let boxItem = Box(width: 100, height: number, color: .systemRed)
            ViewController.boxes.append(boxItem)
        }

    }

    //Detay sayfasında renk değiştir butonu tıklandığında o sayfadaki renk değiştiriliyor. Ayrıca collectionviewdaki aynı özellikteki butonlarında rengi değiştiriliyor ama sayfalar arasındaki bağlantı oluşturulamadı.
    //MARK: - changeDetailBoxColor
    func changeDetailBox(of color: UIColor, height: Int) {
        for i in 0...29 {
            if ViewController.boxes[i].height == height {
                ViewController.boxes[i] = Box(width: 100, height: height, color: .systemGray3)
            }
        }
    }

    //MARK: - refreshButton
    @IBAction func refreshButton(_ sender: Any) {
        randomStaticBox()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    //MARK: - Get Color and height of item
    func getColor(of height: CGFloat) -> UIColor {
        if let color = cellHeightAndColors[height] {
            return color
        }

        guard let randomColor = UIColor.fromString(name: colors.randomElement().rawValue) else { return .white}
        cellHeightAndColors[height] = randomColor
        return randomColor
    }
}
//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return randomItemsInSection
        return ViewController.boxes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let box = ViewController.boxes[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCollectionViewCell", for: indexPath) as? RandomCollectionViewCell else {
            fatalError("Unable to dequeue RandomCell.")
        }
        cell.backgroundColor = getColor(of: CGFloat(box.height))
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.boxNumber = indexPath.row
        vc.color = "\(selectedColorInfo ?? .white)"

        let cellAtIndexPath = collectionView.cellForItem(at: indexPath)
        vc.boxNameBackgroundColor = cellAtIndexPath?.backgroundColor
        vc.height = ViewController.boxes[indexPath.row].height

        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let heights = [100, 130, 200, 170, 150]
        let number = heights[Int(arc4random_uniform(UInt32(heights.count)))]
        let height: Double = Double((1080 / 1920) * number)
        let size = CGSize(width: number, height: Int(height))
        return size
    }
}

//MARK: - RandomColorsLayoutDelegate
extension ViewController: RandomColorsLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForBoxAtIndexPath indexPath: IndexPath) -> CGFloat {
        let randomCGFloat = Int.random(in: 5...10)
        let newInt = randomCGFloat * 15
        return CGFloat(newInt)
    }
}
