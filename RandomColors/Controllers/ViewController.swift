//
//  ViewController.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    //MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!

    private var indexPath: IndexPath = []
    private var selectedColorInfo: UIColor?

    let allColors: [Box] = [SystemRed(), SystemYellow(), SystemGreen(), SystemBlue()]
    var boxes: [Box] = []

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
        guard let maximumNumber = (100...400).randomElement() else { return }
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
        return boxes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCollectionViewCell", for: indexPath) as? RandomCollectionViewCell else {
            fatalError("Unable to dequeue RandomCell.")
        }
        cell.box = boxes[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.boxNumber = boxes[indexPath.row].boxNumber
        let selectedBox = boxes[indexPath.row]
        navigateToDetail(with: selectedBox)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: NSIndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

//MARK: - RandomColorsLayoutDelegate
extension ViewController: RandomColorsLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForBoxAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(boxes[indexPath.row].height)
    }
}
