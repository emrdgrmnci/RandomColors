//
//  RandomColorsLayout.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 12.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

#warning("I got this code from https://www.raywenderlich.com/4829472-uicollectionview-custom-layout-tutorial-pinterest due to I didn't calculate collectionView layouts. I added 'let columns =  [2, 3, 4, 5] columnNumber = columns.randomElement() ?? 3' and 'func reloadData() {self.cache = [UICollectionViewLayoutAttributes]()}' code lines for random column generate and reloading data")

import UIKit

//MARK: - Delegate
protocol RandomColorsLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForBoxAtIndexPath indexPath: IndexPath) -> CGFloat
}

class RandomColorsLayout: UICollectionViewLayout {

    //MARK: - Variables
    weak var delegate: RandomColorsLayoutDelegate?

    private var columnNumber = 3
    private let cellPadding: CGFloat = 3
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        let columns =  [2, 3, 4, 5]
        columnNumber = columns.randomElement() ?? 3
        guard
            cache.isEmpty,
            let collectionView = collectionView
            else {
                return
        }
        let columnWidth = contentWidth / CGFloat(columnNumber)
        var xOffset: [CGFloat] = []
        for column in 0..<columnNumber {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: columnNumber)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            let boxHeight = delegate?.collectionView(
                collectionView,
                heightForBoxAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + boxHeight
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (columnNumber - 1) ? (column + 1) : 0
        }
    }

    //MARK: - layoutAttributesForElements
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

            for attributes in cache {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
            return visibleLayoutAttributes
    }

    //MARK: - layoutAttributesForItem
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }

    //MARK: - reloadData()
    func reloadData() {
        self.cache = [UICollectionViewLayoutAttributes]()
    }
}
