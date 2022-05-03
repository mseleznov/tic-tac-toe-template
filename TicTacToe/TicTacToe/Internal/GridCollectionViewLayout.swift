//
//  GridCollectionViewLayout.swift
//  TicTacToe
//
//  Created by Mykhailo Seleznov on 02.05.2022.
//

import UIKit

class GridCollectionViewLayout: UICollectionViewLayout {

    let gridSpacing: CGFloat = 10.0

    var contentBounds = CGRect.zero
    var cachedAttributes = [UICollectionViewLayoutAttributes]()

    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        let smallerDimension: CGFloat
        let xOffset: CGFloat
        let yOffset: CGFloat

        if contentBounds.size.width < contentBounds.size.height {
            smallerDimension = contentBounds.size.width
            xOffset = 0.0
            yOffset = floor((contentBounds.size.height - smallerDimension) / 2.0)
        }
        else {
            smallerDimension = contentBounds.size.height
            xOffset = floor((contentBounds.size.width - smallerDimension) / 2.0)
            yOffset = 0.0
        }

        let cellSize = floor((smallerDimension - gridSpacing * 4.0) / 3.0)

        cachedAttributes.removeAll()

        for index in 0..<9 {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
            attributes.frame = CGRect(x: xOffset + gridSpacing * CGFloat(index%3 + 1) + cellSize * CGFloat(index%3),
                                      y: yOffset + gridSpacing * CGFloat(index/3 + 1) + cellSize * CGFloat(index/3),
                                      width: cellSize,
                                      height: cellSize)
            cachedAttributes.append(attributes)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter { $0.frame.intersects(rect) }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
}
