//
//  ScoreCollectionViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 03.09.2021.
//

import UIKit

private let scoreCellIdentifier = "Cell"

class ScoreCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var cellWidth: CGFloat{
        guard let flowLayout  = collectionViewLayout as? ScoresCollectionViewFlowLayout
        else { fatalError("ScoreCollectionViewController.collectionViewLayout is not ScoresCollectionViewFlowLayout.") }
        return flowLayout.cellWidth
    }
    
    private var cellHeight: CGFloat{
        guard let flowLayout  = collectionViewLayout as? ScoresCollectionViewFlowLayout
        else { fatalError("ScoreCollectionViewController.collectionViewLayout is not ScoresCollectionViewFlowLayout.") }
        return flowLayout.cellHeight
    }
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        self.collectionView!.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: scoreCellIdentifier)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
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
        
        let fontSizeForName = cellWidth / 8
        let fontSizeForScore = cellWidth / 3
        let nameAttributes: [NSAttributedString.Key: Any] = [.font : UIFont(name: "nunito-extrabold", size: fontSizeForName) ?? UIFont.systemFont(ofSize: 28),
                                                             .foregroundColor : UIColor.playersNameColorOrange,
                                                             .paragraphStyle : paragrafStyle]
        cell.nameLabel.attributedText = NSAttributedString(string: playerName, attributes: nameAttributes)

        guard let playerScore = GameModel.shared.playersScores[playerName]?.reduce(0, {$0 + $1}) else {fatalError("Score for player \(playerName) does not exist.")}
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.3
        let scoreAttributes: [NSAttributedString.Key: Any] = [.font : UIFont(name: "nunito-bold", size: fontSizeForScore) ?? UIFont.systemFont(ofSize: 28),
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
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
    
    //MARK: - selectors

    //MARK: - public funtions
}

