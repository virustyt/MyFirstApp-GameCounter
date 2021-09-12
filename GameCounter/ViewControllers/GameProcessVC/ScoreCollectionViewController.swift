//
//  ScoreCollectionViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 03.09.2021.
//

import UIKit

private let scoreCellIdentifier = "Cell"

class ScoreCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private lazy var collectionViewFlowLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 225, height: 300)
        return layout
    }()
    
    private var cellWidth: CGFloat{
        return cellHeight * 0.85
    }
    
    private var cellHeight:CGFloat{
        return collectionView.frame.height
    }
    
    private var  distanceBetweenCellsCenters: CGFloat {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
              collectionView.visibleCells.count != 0 else {return 0.0}
        let distanceBetweenCellsCenters = cellWidth + flowLayout.minimumLineSpacing
        return distanceBetweenCellsCenters
    }
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        self.collectionView!.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: scoreCellIdentifier)
        collectionView.removeGestureRecognizer(collectionView.panGestureRecognizer)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
        guard let parentViewController = parent as? GameProcessViewController else {return}
        let numberOfSelectedCell = parentViewController.numberOfSelectedCell
        setOffsetForSelectedCell(withIndex: numberOfSelectedCell)
    }
    
    // MARK: - Navigation


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameModel.shared.allPlayers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scoreCellIdentifier, for: indexPath) as? ScoreCollectionViewCell
        else { fatalError("Cell with identifyer \(scoreCellIdentifier) does not exist.") }
        cell.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        cell.layer.cornerRadius = 15

        let playerName = GameModel.shared.allPlayers[indexPath.item]
        let paragrafStyle = NSMutableParagraphStyle()
        paragrafStyle.lineHeightMultiple = 1.07
        
        let nameFontSizeForCellWidth = cellWidth / 8
        let scoreFontSizeForCellWidth = cellWidth / 3
        let nameAttributes: [NSAttributedString.Key: Any] = [.font : UIFont(name: "nunito-extrabold", size: nameFontSizeForCellWidth) ?? UIFont.systemFont(ofSize: 28),
                                                             .foregroundColor : UIColor.playersNameColorOrange,
                                                             .paragraphStyle : paragrafStyle]
        cell.nameLabel.attributedText = NSAttributedString(string: playerName, attributes: nameAttributes)

        guard let playerScore = GameModel.shared.playersScores[playerName] else {fatalError("Score for player \(playerName) does not exist.")}
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.3
        let scoreAttributes: [NSAttributedString.Key: Any] = [.font : UIFont(name: "nunito-bold", size: scoreFontSizeForCellWidth) ?? UIFont.systemFont(ofSize: 28),
                                                              .foregroundColor : UIColor.customWhite,
                                                             .paragraphStyle : paragrafStyle]
        cell.scoreLabel.attributedText = NSAttributedString(string: "\(playerScore)", attributes: scoreAttributes)

        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: cellWidth, height: cellHeight)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let collectionViewFrameWidth = collectionView.frame.width
        let leftInset = (collectionViewFrameWidth - cellWidth) / 2
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
    }

    
    //MARK: - public funtions
    func setOffsetForSelectedCell(withIndex: Int){
        let nextXOffset = distanceBetweenCellsCenters * CGFloat(withIndex)
        let nextpoint = CGPoint(x: nextXOffset, y: 0)
        collectionView.setContentOffset(nextpoint, animated: true)
    }
}

