//
//  CustomCollectionViewLayout.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 03.09.2021.
//

import UIKit

class ScoresCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfCellInCenter:Int = 0 {
        didSet{
            guard let cv = collectionView else {return}
            
            if 0...GameModel.shared.allPlayers.count - 1 ~= numberOfCellInCenter {
                cv.setContentOffset(getCGPointForCellCenter(withIndex: numberOfCellInCenter), animated: true)
            } else {
                guard let numberOfItems = collectionView?.numberOfItems(inSection: 0)
                else {return}
                if numberOfCellInCenter < 0 {
                    numberOfCellInCenter = numberOfItems - 1
                    cv.setContentOffset(getCGPointForCellCenter(withIndex: numberOfCellInCenter), animated: true)
                }
                if numberOfCellInCenter > cv.numberOfItems(inSection: 0) - 1 {
                    numberOfCellInCenter = 0
                }
            }
            NotificationCenter.default.post(name: .centeredCellDidChange, object: self.self)
        }
    }
    
    var cellWidth: CGFloat{
        return cellHeight * 0.85
    }
    
    var cellHeight:CGFloat{
        return collectionView?.frame.height ?? 0
    }
    
    override func prepare() {
        super.prepare()
        reloadOffsetForCellInCenter()
    }
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        minimumInteritemSpacing = 0
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let cv = collectionView,
              cv.numberOfItems(inSection: 0) > 0 else {return CGPoint()}
        
        if velocity.x > 0  {
            numberOfCellInCenter += 1
        } else if velocity.x < 0 {
            numberOfCellInCenter -= 1
        }
        return getCGPointForCellCenter(withIndex: numberOfCellInCenter)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var  distanceBetweenCellsCenters: CGFloat {
        guard collectionView?.numberOfItems(inSection: 0) != 0 else {return 0.0}
        let distanceBetweenCellsCenters = cellWidth + minimumLineSpacing
        return distanceBetweenCellsCenters
    }
    
    func getCGPointForCellCenter(withIndex: Int) -> CGPoint{
        let nextXOffset = distanceBetweenCellsCenters * CGFloat(withIndex)
        let nextPoint = CGPoint(x: nextXOffset, y: 0)
        return nextPoint
    }
    
    func reloadOffsetForCellInCenter(){
        guard let cv = collectionView else {return}
        cv.setContentOffset(getCGPointForCellCenter(withIndex: numberOfCellInCenter), animated: true)
    }
}
