//
//  CustomCollectionViewLayout.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 03.09.2021.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        minimumInteritemSpacing = 0
        itemSize = CGSize(width: 225, height: 300)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
