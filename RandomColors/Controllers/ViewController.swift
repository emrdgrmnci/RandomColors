//
//  ViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

//MARK: - Global constant
let colors = StaticColors.allCases

final class ViewController: UIViewController {

    //MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!

    private var indexPath: IndexPath = []
    private var selectedColorInfo: UIColor?
    private let randomItemsInSection = Int.random(in: 10...30)
    private var cellHeightAndColors = Dictionary<CGFloat, UIColor>()

    let allColors: [Box] = [SystemRed(), SystemYellow(), SystemGreen(), SystemBlue()]
    var boxes = [Box]()

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        randomStaticBox()
        prepareCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBox(_:)), name: Notification.Name("UpdateBox"), object: nil)
    }


    //MARK: - randomStaticBox()
    func randomStaticBox() {
        boxes = []
        guard let maximumNumber = (50...250).randomElement() else { return }
        let total = Array(0...maximumNumber)
        let _ = total.map { _ in
            if let randomBox = allColors.randomElement() {
                boxes.append(randomBox)
            }
        }
    }

    @objc private func updateBox(_ notification: NSNotification) {
        if let userInfo = notification.userInfo as NSDictionary? {
            if let prevColor = userInfo["prevColor"] as? Color, let currColor = userInfo["currColor"] as? Color {
                guard prevColor != currColor else { return }
                for index in 0..<boxes.count {
                    if boxes[index].color == currColor {
                        switch prevColor {
                        case .systemBlue:
                            boxes[index] = SystemBlue()
                        case .systemGreen:
                            boxes[index] = SystemGreen()
                        case .systemRed:
                            boxes[index] = SystemRed()
                        case .systemYellow:
                            boxes[index] = SystemYellow()
                        }
                    }
                }
                reloadDataAndLayout()
            }
        }
    }

    private func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? RandomColorsLayout {
            layout.delegate = self
        }
    }

    //Detay sayfasında renk değiştir butonu tıklandığında o sayfadaki renk değiştiriliyor. Ayrıca collectionviewdaki aynı özellikteki butonlarında rengi değiştiriliyor ama sayfalar arasındaki bağlantı oluşturulamadı.
    //MARK: - changeDetailBoxColor
    //    func changeDetailBox(of color: UIColor, height: Int) {
    //        for i in 0...29 {
    //            if ViewController.boxes[i].height == height {
    //                ViewController.boxes[i] = Box(width: 100, height: height, boxName: "", color: )
    //                ViewController.boxes[i] = Box(width: 100, height: height, color: .systemGray3)
    //            }
    //        }
    //    }

    private func reloadDataAndLayout() {
        if let layout = collectionView.collectionViewLayout as? RandomColorsLayout {
            layout.invalidateLayout()
            layout.reloadData()
        }
        collectionView.reloadData()
    }

    private func navigateToDetail(with box: Box) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        vc.selectedBox = box
        navigationController?.pushViewController(vc, animated: true)
    }

    //MARK: - refreshButton
    @IBAction func refreshButton(_ sender: Any) {
        randomStaticBox()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return randomItemsInSection
        return boxes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let box = boxes[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCollectionViewCell", for: indexPath) as? RandomCollectionViewCell else {
            fatalError("Unable to dequeue RandomCell.")
        }
        cell.box = boxes[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {



}

//MARK: - RandomColorsLayoutDelegate
extension ViewController: RandomColorsLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForBoxAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(boxes[indexPath.row].height)
    }
}
