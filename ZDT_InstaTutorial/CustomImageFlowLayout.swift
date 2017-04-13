//
//  CustomImageFlowLayout.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    override var itemSize: CGSize {
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = 8

            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns)) / numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }

    func setupLayout() {
        
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .vertical
    }

}
