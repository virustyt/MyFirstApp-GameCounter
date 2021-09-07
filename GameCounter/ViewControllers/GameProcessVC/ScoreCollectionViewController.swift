//
//  ScoreCollectionViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 03.09.2021.
//

import UIKit

private let scoreCellIdentifier = "Cell"

class ScoreCollectionViewController: UICollectionViewController {

    private lazy var customCollectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 225, height: 300)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CustomCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        self.collectionView!.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: scoreCellIdentifier)
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
        let nameAttributes: [NSAttributedString.Key: Any] = [.font : UIFont(name: "nunito-extrabold", size: 28) ?? UIFont.systemFont(ofSize: 28),
                                                             .foregroundColor : UIColor.playersNameColorOrange,
                                                             .paragraphStyle : paragrafStyle]
        cell.nameLabel.attributedText = NSAttributedString(string: playerName, attributes: nameAttributes)
        
        guard let playerScore = GameModel.shared.playersScores[playerName] else {fatalError("Score for player \(playerName) does not exist.")}
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.3
        let scoreAttributes: [NSAttributedString.Key: Any] = [.font : UIFont(name: "nunito-bold", size: 100) ?? UIFont.systemFont(ofSize: 28),
                                                              .foregroundColor : UIColor.customWhite,
                                                             .paragraphStyle : paragrafStyle]
        cell.scoreLabel.attributedText = NSAttributedString(string: "\(playerScore)", attributes: scoreAttributes)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

