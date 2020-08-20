//
//  CustomCollectionViewFlowLayout.swift
//  PTPaniniConsumerExp
//
//  Created by Murali on 20/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private var minimumColumnWidth: CGFloat = 200
    private var cellRatio: CGFloat = 1
    private var cellHeightExtent: CGFloat = 0

    required init(minColumnWidth: CGFloat, cellRatio: CGFloat, cellHeightExtent: CGFloat) {
        self.minimumColumnWidth = minColumnWidth
        self.cellRatio = cellRatio > 0 ? cellRatio : 1
        self.cellHeightExtent = cellHeightExtent
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        self.update(minColumnWidth: minimumColumnWidth, cellRatio: cellRatio, cellHeightExtent: cellHeightExtent)
    }
    
    func update(minColumnWidth: CGFloat, cellRatio: CGFloat, cellHeightExtent: CGFloat) {
        guard let cv = collectionView else { return }
        
        //        if Utility.sharedInstance.isIpad {
        let availableWidth = cv.bounds.size.width//inset(by: cv.layoutMargins).size.width
        let maxColumns = max(1, Int(availableWidth / (minimumColumnWidth + minimumInteritemSpacing)))
        var cellWidth = (availableWidth / CGFloat(maxColumns)) - (CGFloat(maxColumns - 1) * minimumInteritemSpacing)
        cellWidth.round(.down)
        let cellHeight = (cellWidth * cellRatio) + cellHeightExtent
        
        self.itemSize = CGSize(width: cellWidth, height: max(cellHeight, 0))
        
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            self.sectionInsetReference = .fromSafeArea
        } else { }
    }
    
}
